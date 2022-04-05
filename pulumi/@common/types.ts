/*

 ATTENTION!
 All types here are available globally throughout the app.
 See tsconfig.json

*/

export type StringMap = {[key: string]: string};

export interface GlobalOptions {
    owner: string;
}

export interface Context {
    namePrefix: string;
    owner: string
}
