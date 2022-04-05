import {CONSTANTS} from "./constants";
import {StringMap, Context} from "./types";
import {OPTIONS} from "../run_settings/options";

/**
 * Model for the argument to pass to setScenarioInfo()
 */
export interface SetScenarioInfo {
    scenarioName: string;

    description?: string;
    tags?: StringMap;
}

export type ScenarioInfo = Required<SetScenarioInfo>;


export abstract class Scenario {
    protected readonly context: Readonly<Context>;
    protected info: ScenarioInfo;

    protected constructor(
        namePrefix: string = CONSTANTS.namePrefix,
        owner: string = OPTIONS.owner)
    {
        this.context = {
            namePrefix: namePrefix,
            owner: owner
        }

        this.info = this.buildInfo();
    }

    protected get scenarioName(): string { return this.info['scenarioName']; }
    protected get description(): string { return this.info['description']; }
    protected get tags(): StringMap { return this.info['tags']; }

    public callIt(suffix: string): string {
        return callIt(this.context.namePrefix, this.scenarioName, this.context.owner, suffix);
    }

    abstract setScenarioInfo(): SetScenarioInfo;

    // region Info Builders

    /**
     * This function isn't really necessary as it just calls the static function,
     * but it keeps the code readable and acts as an abstraction.
     */
    private buildInfo(): ScenarioInfo {
        return Scenario.buildInfo(this.setScenarioInfo(), this.context);
    }

    /**
     * A function that builds scenario info from the user arguments.
     *
     * This function was made static to avoid the silly mistakes of calling on a scenario
     * info that's not yet built.
     */
    private static buildInfo(userInfo: Readonly<SetScenarioInfo>, context: Readonly<Context>): ScenarioInfo {

        let description = Scenario.buildDescription(
            userInfo.scenarioName,
            userInfo.description
        );

        let tags = Scenario.buildTags(
            description,
            context.owner,
            userInfo.tags
        );

        return {
            scenarioName: userInfo.scenarioName,
            description: description,
            tags: tags,
        }
    }

    private static buildTags(description: string, owner: string, extraTags?: StringMap) {
        extraTags = extraTags ?? {};
        let result = {
            owner: owner,
            description: description
        }

        return Object.assign(result, extraTags);
    }

    private static buildDescription(scenarioName: string, text?: string): string {
        let desc = scenarioName;

        if (!text) {
            desc = `${desc} - ${text}`;
        }

        return desc;
    }

    // endregion
}


function callIt(oak9Prefix: string, scenarioName: string, owner: string, suffix: string): string {
    return [oak9Prefix, scenarioName, owner, suffix].join('-');
}
