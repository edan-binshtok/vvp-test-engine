#!/bin/bash
 
# ============LICENSE_START========================================== 
# org.onap.vvp/test-engine
# ===================================================================
# Copyright © 2017 AT&T Intellectual Property. All rights reserved.
# ===================================================================
#
# Unless otherwise specified, all software contained herein is licensed
# under the Apache License, Version 2.0 (the “License”);
# you may not use this software except in compliance with the License.
# You may obtain a copy of the License at
#
#             http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
#
# Unless otherwise specified, all documentation contained herein is licensed
# under the Creative Commons License, Attribution 4.0 Intl. (the “License”);
# you may not use this documentation except in compliance with the License.
# You may obtain a copy of the License at
#
#             https://creativecommons.org/licenses/by/4.0/
#
# Unless required by applicable law or agreed to in writing, documentation
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# ============LICENSE_END============================================
#
# ECOMP is a trademark and service mark of AT&T Intellectual Property.

Python=`which python`

if [ -z $Python ] ; then
 echo "[ ERR ] : Python is not installed"
 exit
fi

checkResault ()
{
  value=$1
  func=$2

  if [ $value -ne "0" ] ; then
    echo "[ ERR ] Function $func failed"
    exit 255
  fi
}




#echo "This script should be run ONLY for the first time the application is deployed."
returnCode=$?
checkResault $returnCode 'makemigrations'
#echo "Creating migration for the first time..."
#python /app/manage.py makemigrations iceci
#returnCode=$?
#checkResault $returnCode 'makemigrations'

echo "Checking migration is valid..."
python /app/manage.py check
returnCode=$?
checkResault $returnCode 'check'

echo "Creating Database Tables..."
python /app/manage.py migrate --noinput
returnCode=$?
checkResault $returnCode 'migrate'



##################################################################################################################################
# If one wishes to view SQL generated by specific migration, the following command can be used. 0001 is a specific migration name
#
# python manage.py sqlmigrate engagementmanager 0001
##################################################################################################################################

echo "import django; django.setup(); from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('iceci.admin', 'iceci.admin@att.com', 'Aa123456') " | $Python /app/manage.py shell
