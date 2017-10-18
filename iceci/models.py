 
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
from __future__ import unicode_literals
from django.db import models
import datetime
from django.conf import settings

class TestResults(models.Model):
    testType = models.CharField(max_length=64)
    testFeature = models.CharField(max_length=64)
    testName = models.CharField(max_length=64)
    testResult = models.CharField(max_length=64)
    notes = models.TextField(null=True, blank=True)
    duration = models.CharField(max_length=64)
    build_id = models.TextField(null=True, blank=True,default=settings.ICE_BUILD_REPORT_NUM)
    create_time = models.DateTimeField('creation time', default=datetime.datetime.now)
    class Meta:
        db_table = "ice_test_results"
        verbose_name_plural = 'Tests Results'