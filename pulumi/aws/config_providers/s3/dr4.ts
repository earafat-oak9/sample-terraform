import * as aws from '@pulumi/aws';
import {Scenario, SetScenarioInfo} from "../../../@common/scenario";

export default class dr4 extends Scenario {

    setScenarioInfo(): SetScenarioInfo {
        return {
            scenarioName: 'dr4',
            description: 'S3 bucket with server-side encryption enabled'
        }
    }

    constructor() {
        super();

        const key = new aws.kms.Key(this.callIt('key'), {
            deletionWindowInDays: 10,
            enableKeyRotation: true,
            policy: '',
            description: this.description,
            tags: this.tags
        });

        const bucket = new aws.s3.Bucket(this.callIt('bucket'), {
            serverSideEncryptionConfiguration: {
                rule: {
                    applyServerSideEncryptionByDefault: {
                        kmsMasterKeyId: '',
                        sseAlgorithm: 'aws:kms'
                    }
                }
            }
        });

        new aws.s3.BucketServerSideEncryptionConfigurationV2(this.callIt('sse-config'), {
            bucket: bucket.bucket,
            rules: [{
                applyServerSideEncryptionByDefault: {
                    kmsMasterKeyId: key.keyId,
                    sseAlgorithm: 'aws:kms'
                }
            }]
        });
    }
}
