import * as aws from '@pulumi/aws';
import {Scenario, SetScenarioInfo} from "../../../@common/scenario";

export default class g4a extends Scenario {

    setScenarioInfo(): SetScenarioInfo {
        return {
            scenarioName: 'g4a',
            description: 'Bare minimum to deploy an s3 bucket.'
        }
    }

    constructor() {
        super();

        new aws.s3.Bucket(this.callIt('bucket'), {
            tags: this.tags,
            serverSideEncryptionConfiguration: {
                rule: {
                    applyServerSideEncryptionByDefault: {
                        kmsMasterKeyId: '',
                        sseAlgorithm: 'aws:kms'
                    }
                }
            }
        });
    }
}
