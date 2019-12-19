import * as Long from "long";

import * as $protobuf from "@apollo/protobufjs";
/** Namespace product. */
export namespace product {

    /** Properties of a LanguageSetting. */
    interface ILanguageSetting {

        /** LanguageSetting language */
        language?: (string|null);

        /** LanguageSetting option */
        option?: (product.LanguageOption|null);
    }

    /** Represents a LanguageSetting. */
    class LanguageSetting implements ILanguageSetting {

        /**
         * Constructs a new LanguageSetting.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.ILanguageSetting);

        /** LanguageSetting language. */
        public language: string;

        /** LanguageSetting option. */
        public option: product.LanguageOption;

        /**
         * Creates a new LanguageSetting instance using the specified properties.
         * @param [properties] Properties to set
         * @returns LanguageSetting instance
         */
        public static create(properties?: product.ILanguageSetting): product.LanguageSetting;

        /**
         * Encodes the specified LanguageSetting message. Does not implicitly {@link product.LanguageSetting.verify|verify} messages.
         * @param message LanguageSetting message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.ILanguageSetting, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified LanguageSetting message, length delimited. Does not implicitly {@link product.LanguageSetting.verify|verify} messages.
         * @param message LanguageSetting message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.ILanguageSetting, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a LanguageSetting message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns LanguageSetting
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.LanguageSetting;

        /**
         * Decodes a LanguageSetting message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns LanguageSetting
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.LanguageSetting;

        /**
         * Verifies a LanguageSetting message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a LanguageSetting message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns LanguageSetting
         */
        public static fromObject(object: { [k: string]: any }): product.LanguageSetting;

        /**
         * Creates a plain object from a LanguageSetting message. Also converts values to other types if specified.
         * @param message LanguageSetting
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.LanguageSetting, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this LanguageSetting to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** Properties of a UserSettings. */
    interface IUserSettings {

        /** UserSettings installPath */
        installPath?: (string|null);

        /** UserSettings playRegion */
        playRegion?: (string|null);

        /** UserSettings desktopShortcut */
        desktopShortcut?: (product.ShortcutOption|null);

        /** UserSettings startmenuShortcut */
        startmenuShortcut?: (product.ShortcutOption|null);

        /** UserSettings languageSettings */
        languageSettings?: (product.LanguageSettingType|null);

        /** UserSettings selectedTextLanguage */
        selectedTextLanguage?: (string|null);

        /** UserSettings selectedSpeechLanguage */
        selectedSpeechLanguage?: (string|null);

        /** UserSettings languages */
        languages?: (product.ILanguageSetting[]|null);

        /** UserSettings gfxOverrideTags */
        gfxOverrideTags?: (string|null);

        /** UserSettings versionbranch */
        versionbranch?: (string|null);
    }

    /** Represents a UserSettings. */
    class UserSettings implements IUserSettings {

        /**
         * Constructs a new UserSettings.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.IUserSettings);

        /** UserSettings installPath. */
        public installPath: string;

        /** UserSettings playRegion. */
        public playRegion: string;

        /** UserSettings desktopShortcut. */
        public desktopShortcut: product.ShortcutOption;

        /** UserSettings startmenuShortcut. */
        public startmenuShortcut: product.ShortcutOption;

        /** UserSettings languageSettings. */
        public languageSettings: product.LanguageSettingType;

        /** UserSettings selectedTextLanguage. */
        public selectedTextLanguage: string;

        /** UserSettings selectedSpeechLanguage. */
        public selectedSpeechLanguage: string;

        /** UserSettings languages. */
        public languages: product.ILanguageSetting[];

        /** UserSettings gfxOverrideTags. */
        public gfxOverrideTags: string;

        /** UserSettings versionbranch. */
        public versionbranch: string;

        /**
         * Creates a new UserSettings instance using the specified properties.
         * @param [properties] Properties to set
         * @returns UserSettings instance
         */
        public static create(properties?: product.IUserSettings): product.UserSettings;

        /**
         * Encodes the specified UserSettings message. Does not implicitly {@link product.UserSettings.verify|verify} messages.
         * @param message UserSettings message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.IUserSettings, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified UserSettings message, length delimited. Does not implicitly {@link product.UserSettings.verify|verify} messages.
         * @param message UserSettings message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.IUserSettings, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a UserSettings message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns UserSettings
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.UserSettings;

        /**
         * Decodes a UserSettings message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns UserSettings
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.UserSettings;

        /**
         * Verifies a UserSettings message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a UserSettings message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns UserSettings
         */
        public static fromObject(object: { [k: string]: any }): product.UserSettings;

        /**
         * Creates a plain object from a UserSettings message. Also converts values to other types if specified.
         * @param message UserSettings
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.UserSettings, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this UserSettings to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** Properties of an InstallHandshake. */
    interface IInstallHandshake {

        /** InstallHandshake product */
        product?: (string|null);

        /** InstallHandshake uid */
        uid?: (string|null);

        /** InstallHandshake settings */
        settings?: (product.IUserSettings|null);
    }

    /** Represents an InstallHandshake. */
    class InstallHandshake implements IInstallHandshake {

        /**
         * Constructs a new InstallHandshake.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.IInstallHandshake);

        /** InstallHandshake product. */
        public product: string;

        /** InstallHandshake uid. */
        public uid: string;

        /** InstallHandshake settings. */
        public settings?: (product.IUserSettings|null);

        /**
         * Creates a new InstallHandshake instance using the specified properties.
         * @param [properties] Properties to set
         * @returns InstallHandshake instance
         */
        public static create(properties?: product.IInstallHandshake): product.InstallHandshake;

        /**
         * Encodes the specified InstallHandshake message. Does not implicitly {@link product.InstallHandshake.verify|verify} messages.
         * @param message InstallHandshake message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.IInstallHandshake, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified InstallHandshake message, length delimited. Does not implicitly {@link product.InstallHandshake.verify|verify} messages.
         * @param message InstallHandshake message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.IInstallHandshake, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes an InstallHandshake message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns InstallHandshake
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.InstallHandshake;

        /**
         * Decodes an InstallHandshake message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns InstallHandshake
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.InstallHandshake;

        /**
         * Verifies an InstallHandshake message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates an InstallHandshake message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns InstallHandshake
         */
        public static fromObject(object: { [k: string]: any }): product.InstallHandshake;

        /**
         * Creates a plain object from an InstallHandshake message. Also converts values to other types if specified.
         * @param message InstallHandshake
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.InstallHandshake, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this InstallHandshake to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** Properties of a BuildConfig. */
    interface IBuildConfig {

        /** BuildConfig region */
        region?: (string|null);

        /** BuildConfig buildConfig */
        buildConfig?: (string|null);
    }

    /** Represents a BuildConfig. */
    class BuildConfig implements IBuildConfig {

        /**
         * Constructs a new BuildConfig.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.IBuildConfig);

        /** BuildConfig region. */
        public region: string;

        /** BuildConfig buildConfig. */
        public buildConfig: string;

        /**
         * Creates a new BuildConfig instance using the specified properties.
         * @param [properties] Properties to set
         * @returns BuildConfig instance
         */
        public static create(properties?: product.IBuildConfig): product.BuildConfig;

        /**
         * Encodes the specified BuildConfig message. Does not implicitly {@link product.BuildConfig.verify|verify} messages.
         * @param message BuildConfig message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.IBuildConfig, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified BuildConfig message, length delimited. Does not implicitly {@link product.BuildConfig.verify|verify} messages.
         * @param message BuildConfig message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.IBuildConfig, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a BuildConfig message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns BuildConfig
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.BuildConfig;

        /**
         * Decodes a BuildConfig message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns BuildConfig
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.BuildConfig;

        /**
         * Verifies a BuildConfig message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a BuildConfig message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns BuildConfig
         */
        public static fromObject(object: { [k: string]: any }): product.BuildConfig;

        /**
         * Creates a plain object from a BuildConfig message. Also converts values to other types if specified.
         * @param message BuildConfig
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.BuildConfig, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this BuildConfig to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** Properties of a BaseProductState. */
    interface IBaseProductState {

        /** BaseProductState installed */
        installed?: (boolean|null);

        /** BaseProductState playable */
        playable?: (boolean|null);

        /** BaseProductState updateComplete */
        updateComplete?: (boolean|null);

        /** BaseProductState backgroundDownloadAvailable */
        backgroundDownloadAvailable?: (boolean|null);

        /** BaseProductState backgroundDownloadComplete */
        backgroundDownloadComplete?: (boolean|null);

        /** BaseProductState currentVersion */
        currentVersion?: (string|null);

        /** BaseProductState currentVersionStr */
        currentVersionStr?: (string|null);

        /** BaseProductState installedBuildConfig */
        installedBuildConfig?: (product.IBuildConfig[]|null);

        /** BaseProductState backgroundDownloadBuildConfig */
        backgroundDownloadBuildConfig?: (product.IBuildConfig[]|null);

        /** BaseProductState decryptionKey */
        decryptionKey?: (string|null);

        /** BaseProductState completedInstallActions */
        completedInstallActions?: (string[]|null);
    }

    /** Represents a BaseProductState. */
    class BaseProductState implements IBaseProductState {

        /**
         * Constructs a new BaseProductState.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.IBaseProductState);

        /** BaseProductState installed. */
        public installed: boolean;

        /** BaseProductState playable. */
        public playable: boolean;

        /** BaseProductState updateComplete. */
        public updateComplete: boolean;

        /** BaseProductState backgroundDownloadAvailable. */
        public backgroundDownloadAvailable: boolean;

        /** BaseProductState backgroundDownloadComplete. */
        public backgroundDownloadComplete: boolean;

        /** BaseProductState currentVersion. */
        public currentVersion: string;

        /** BaseProductState currentVersionStr. */
        public currentVersionStr: string;

        /** BaseProductState installedBuildConfig. */
        public installedBuildConfig: product.IBuildConfig[];

        /** BaseProductState backgroundDownloadBuildConfig. */
        public backgroundDownloadBuildConfig: product.IBuildConfig[];

        /** BaseProductState decryptionKey. */
        public decryptionKey: string;

        /** BaseProductState completedInstallActions. */
        public completedInstallActions: string[];

        /**
         * Creates a new BaseProductState instance using the specified properties.
         * @param [properties] Properties to set
         * @returns BaseProductState instance
         */
        public static create(properties?: product.IBaseProductState): product.BaseProductState;

        /**
         * Encodes the specified BaseProductState message. Does not implicitly {@link product.BaseProductState.verify|verify} messages.
         * @param message BaseProductState message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.IBaseProductState, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified BaseProductState message, length delimited. Does not implicitly {@link product.BaseProductState.verify|verify} messages.
         * @param message BaseProductState message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.IBaseProductState, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a BaseProductState message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns BaseProductState
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.BaseProductState;

        /**
         * Decodes a BaseProductState message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns BaseProductState
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.BaseProductState;

        /**
         * Verifies a BaseProductState message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a BaseProductState message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns BaseProductState
         */
        public static fromObject(object: { [k: string]: any }): product.BaseProductState;

        /**
         * Creates a plain object from a BaseProductState message. Also converts values to other types if specified.
         * @param message BaseProductState
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.BaseProductState, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this BaseProductState to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** Properties of a BackfillProgress. */
    interface IBackfillProgress {

        /** BackfillProgress progress */
        progress?: (number|null);

        /** BackfillProgress backgrounddownload */
        backgrounddownload?: (boolean|null);

        /** BackfillProgress paused */
        paused?: (boolean|null);

        /** BackfillProgress downloadLimit */
        downloadLimit?: (number|Long|null);
    }

    /** Represents a BackfillProgress. */
    class BackfillProgress implements IBackfillProgress {

        /**
         * Constructs a new BackfillProgress.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.IBackfillProgress);

        /** BackfillProgress progress. */
        public progress: number;

        /** BackfillProgress backgrounddownload. */
        public backgrounddownload: boolean;

        /** BackfillProgress paused. */
        public paused: boolean;

        /** BackfillProgress downloadLimit. */
        public downloadLimit: (number|Long);

        /**
         * Creates a new BackfillProgress instance using the specified properties.
         * @param [properties] Properties to set
         * @returns BackfillProgress instance
         */
        public static create(properties?: product.IBackfillProgress): product.BackfillProgress;

        /**
         * Encodes the specified BackfillProgress message. Does not implicitly {@link product.BackfillProgress.verify|verify} messages.
         * @param message BackfillProgress message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.IBackfillProgress, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified BackfillProgress message, length delimited. Does not implicitly {@link product.BackfillProgress.verify|verify} messages.
         * @param message BackfillProgress message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.IBackfillProgress, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a BackfillProgress message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns BackfillProgress
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.BackfillProgress;

        /**
         * Decodes a BackfillProgress message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns BackfillProgress
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.BackfillProgress;

        /**
         * Verifies a BackfillProgress message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a BackfillProgress message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns BackfillProgress
         */
        public static fromObject(object: { [k: string]: any }): product.BackfillProgress;

        /**
         * Creates a plain object from a BackfillProgress message. Also converts values to other types if specified.
         * @param message BackfillProgress
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.BackfillProgress, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this BackfillProgress to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** Properties of a RepairProgress. */
    interface IRepairProgress {

        /** RepairProgress progress */
        progress?: (number|null);
    }

    /** Represents a RepairProgress. */
    class RepairProgress implements IRepairProgress {

        /**
         * Constructs a new RepairProgress.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.IRepairProgress);

        /** RepairProgress progress. */
        public progress: number;

        /**
         * Creates a new RepairProgress instance using the specified properties.
         * @param [properties] Properties to set
         * @returns RepairProgress instance
         */
        public static create(properties?: product.IRepairProgress): product.RepairProgress;

        /**
         * Encodes the specified RepairProgress message. Does not implicitly {@link product.RepairProgress.verify|verify} messages.
         * @param message RepairProgress message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.IRepairProgress, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified RepairProgress message, length delimited. Does not implicitly {@link product.RepairProgress.verify|verify} messages.
         * @param message RepairProgress message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.IRepairProgress, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a RepairProgress message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns RepairProgress
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.RepairProgress;

        /**
         * Decodes a RepairProgress message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns RepairProgress
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.RepairProgress;

        /**
         * Verifies a RepairProgress message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a RepairProgress message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns RepairProgress
         */
        public static fromObject(object: { [k: string]: any }): product.RepairProgress;

        /**
         * Creates a plain object from a RepairProgress message. Also converts values to other types if specified.
         * @param message RepairProgress
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.RepairProgress, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this RepairProgress to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** Properties of an UpdateProgress. */
    interface IUpdateProgress {

        /** UpdateProgress lastDiscSetUsed */
        lastDiscSetUsed?: (string|null);

        /** UpdateProgress progress */
        progress?: (number|null);

        /** UpdateProgress discIgnored */
        discIgnored?: (boolean|null);

        /** UpdateProgress totalToDownload */
        totalToDownload?: (number|Long|null);

        /** UpdateProgress downloadRemaining */
        downloadRemaining?: (number|Long|null);
    }

    /** Represents an UpdateProgress. */
    class UpdateProgress implements IUpdateProgress {

        /**
         * Constructs a new UpdateProgress.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.IUpdateProgress);

        /** UpdateProgress lastDiscSetUsed. */
        public lastDiscSetUsed: string;

        /** UpdateProgress progress. */
        public progress: number;

        /** UpdateProgress discIgnored. */
        public discIgnored: boolean;

        /** UpdateProgress totalToDownload. */
        public totalToDownload: (number|Long);

        /** UpdateProgress downloadRemaining. */
        public downloadRemaining: (number|Long);

        /**
         * Creates a new UpdateProgress instance using the specified properties.
         * @param [properties] Properties to set
         * @returns UpdateProgress instance
         */
        public static create(properties?: product.IUpdateProgress): product.UpdateProgress;

        /**
         * Encodes the specified UpdateProgress message. Does not implicitly {@link product.UpdateProgress.verify|verify} messages.
         * @param message UpdateProgress message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.IUpdateProgress, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified UpdateProgress message, length delimited. Does not implicitly {@link product.UpdateProgress.verify|verify} messages.
         * @param message UpdateProgress message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.IUpdateProgress, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes an UpdateProgress message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns UpdateProgress
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.UpdateProgress;

        /**
         * Decodes an UpdateProgress message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns UpdateProgress
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.UpdateProgress;

        /**
         * Verifies an UpdateProgress message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates an UpdateProgress message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns UpdateProgress
         */
        public static fromObject(object: { [k: string]: any }): product.UpdateProgress;

        /**
         * Creates a plain object from an UpdateProgress message. Also converts values to other types if specified.
         * @param message UpdateProgress
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.UpdateProgress, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this UpdateProgress to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** Properties of a CachedProductState. */
    interface ICachedProductState {

        /** CachedProductState baseProductState */
        baseProductState?: (product.IBaseProductState|null);

        /** CachedProductState backfillProgress */
        backfillProgress?: (product.IBackfillProgress|null);

        /** CachedProductState repairProgress */
        repairProgress?: (product.IRepairProgress|null);

        /** CachedProductState updateProgress */
        updateProgress?: (product.IUpdateProgress|null);
    }

    /** Represents a CachedProductState. */
    class CachedProductState implements ICachedProductState {

        /**
         * Constructs a new CachedProductState.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.ICachedProductState);

        /** CachedProductState baseProductState. */
        public baseProductState?: (product.IBaseProductState|null);

        /** CachedProductState backfillProgress. */
        public backfillProgress?: (product.IBackfillProgress|null);

        /** CachedProductState repairProgress. */
        public repairProgress?: (product.IRepairProgress|null);

        /** CachedProductState updateProgress. */
        public updateProgress?: (product.IUpdateProgress|null);

        /**
         * Creates a new CachedProductState instance using the specified properties.
         * @param [properties] Properties to set
         * @returns CachedProductState instance
         */
        public static create(properties?: product.ICachedProductState): product.CachedProductState;

        /**
         * Encodes the specified CachedProductState message. Does not implicitly {@link product.CachedProductState.verify|verify} messages.
         * @param message CachedProductState message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.ICachedProductState, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified CachedProductState message, length delimited. Does not implicitly {@link product.CachedProductState.verify|verify} messages.
         * @param message CachedProductState message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.ICachedProductState, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a CachedProductState message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns CachedProductState
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.CachedProductState;

        /**
         * Decodes a CachedProductState message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns CachedProductState
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.CachedProductState;

        /**
         * Verifies a CachedProductState message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a CachedProductState message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns CachedProductState
         */
        public static fromObject(object: { [k: string]: any }): product.CachedProductState;

        /**
         * Creates a plain object from a CachedProductState message. Also converts values to other types if specified.
         * @param message CachedProductState
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.CachedProductState, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this CachedProductState to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** Properties of a ProductOperations. */
    interface IProductOperations {

        /** ProductOperations activeOperation */
        activeOperation?: (product.Operation|null);

        /** ProductOperations priority */
        priority?: (number|Long|null);
    }

    /** Represents a ProductOperations. */
    class ProductOperations implements IProductOperations {

        /**
         * Constructs a new ProductOperations.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.IProductOperations);

        /** ProductOperations activeOperation. */
        public activeOperation: product.Operation;

        /** ProductOperations priority. */
        public priority: (number|Long);

        /**
         * Creates a new ProductOperations instance using the specified properties.
         * @param [properties] Properties to set
         * @returns ProductOperations instance
         */
        public static create(properties?: product.IProductOperations): product.ProductOperations;

        /**
         * Encodes the specified ProductOperations message. Does not implicitly {@link product.ProductOperations.verify|verify} messages.
         * @param message ProductOperations message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.IProductOperations, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified ProductOperations message, length delimited. Does not implicitly {@link product.ProductOperations.verify|verify} messages.
         * @param message ProductOperations message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.IProductOperations, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a ProductOperations message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns ProductOperations
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.ProductOperations;

        /**
         * Decodes a ProductOperations message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns ProductOperations
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.ProductOperations;

        /**
         * Verifies a ProductOperations message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a ProductOperations message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns ProductOperations
         */
        public static fromObject(object: { [k: string]: any }): product.ProductOperations;

        /**
         * Creates a plain object from a ProductOperations message. Also converts values to other types if specified.
         * @param message ProductOperations
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.ProductOperations, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this ProductOperations to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** Properties of a ProductInstall. */
    interface IProductInstall {

        /** ProductInstall uid */
        uid?: (string|null);

        /** ProductInstall productCode */
        productCode?: (string|null);

        /** ProductInstall settings */
        settings?: (product.IUserSettings|null);

        /** ProductInstall cachedProductState */
        cachedProductState?: (product.ICachedProductState|null);

        /** ProductInstall productOperations */
        productOperations?: (product.IProductOperations|null);
    }

    /** Represents a ProductInstall. */
    class ProductInstall implements IProductInstall {

        /**
         * Constructs a new ProductInstall.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.IProductInstall);

        /** ProductInstall uid. */
        public uid: string;

        /** ProductInstall productCode. */
        public productCode: string;

        /** ProductInstall settings. */
        public settings?: (product.IUserSettings|null);

        /** ProductInstall cachedProductState. */
        public cachedProductState?: (product.ICachedProductState|null);

        /** ProductInstall productOperations. */
        public productOperations?: (product.IProductOperations|null);

        /**
         * Creates a new ProductInstall instance using the specified properties.
         * @param [properties] Properties to set
         * @returns ProductInstall instance
         */
        public static create(properties?: product.IProductInstall): product.ProductInstall;

        /**
         * Encodes the specified ProductInstall message. Does not implicitly {@link product.ProductInstall.verify|verify} messages.
         * @param message ProductInstall message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.IProductInstall, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified ProductInstall message, length delimited. Does not implicitly {@link product.ProductInstall.verify|verify} messages.
         * @param message ProductInstall message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.IProductInstall, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a ProductInstall message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns ProductInstall
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.ProductInstall;

        /**
         * Decodes a ProductInstall message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns ProductInstall
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.ProductInstall;

        /**
         * Verifies a ProductInstall message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a ProductInstall message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns ProductInstall
         */
        public static fromObject(object: { [k: string]: any }): product.ProductInstall;

        /**
         * Creates a plain object from a ProductInstall message. Also converts values to other types if specified.
         * @param message ProductInstall
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.ProductInstall, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this ProductInstall to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** Properties of a ProductConfig. */
    interface IProductConfig {

        /** ProductConfig productCode */
        productCode?: (string|null);

        /** ProductConfig metadataHash */
        metadataHash?: (string|null);

        /** ProductConfig timestamp */
        timestamp?: (string|null);
    }

    /** Represents a ProductConfig. */
    class ProductConfig implements IProductConfig {

        /**
         * Constructs a new ProductConfig.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.IProductConfig);

        /** ProductConfig productCode. */
        public productCode: string;

        /** ProductConfig metadataHash. */
        public metadataHash: string;

        /** ProductConfig timestamp. */
        public timestamp: string;

        /**
         * Creates a new ProductConfig instance using the specified properties.
         * @param [properties] Properties to set
         * @returns ProductConfig instance
         */
        public static create(properties?: product.IProductConfig): product.ProductConfig;

        /**
         * Encodes the specified ProductConfig message. Does not implicitly {@link product.ProductConfig.verify|verify} messages.
         * @param message ProductConfig message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.IProductConfig, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified ProductConfig message, length delimited. Does not implicitly {@link product.ProductConfig.verify|verify} messages.
         * @param message ProductConfig message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.IProductConfig, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a ProductConfig message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns ProductConfig
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.ProductConfig;

        /**
         * Decodes a ProductConfig message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns ProductConfig
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.ProductConfig;

        /**
         * Verifies a ProductConfig message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a ProductConfig message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns ProductConfig
         */
        public static fromObject(object: { [k: string]: any }): product.ProductConfig;

        /**
         * Creates a plain object from a ProductConfig message. Also converts values to other types if specified.
         * @param message ProductConfig
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.ProductConfig, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this ProductConfig to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** Properties of an ActiveProcess. */
    interface IActiveProcess {

        /** ActiveProcess processName */
        processName?: (string|null);

        /** ActiveProcess pid */
        pid?: (number|null);

        /** ActiveProcess uri */
        uri?: (string[]|null);
    }

    /** Represents an ActiveProcess. */
    class ActiveProcess implements IActiveProcess {

        /**
         * Constructs a new ActiveProcess.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.IActiveProcess);

        /** ActiveProcess processName. */
        public processName: string;

        /** ActiveProcess pid. */
        public pid: number;

        /** ActiveProcess uri. */
        public uri: string[];

        /**
         * Creates a new ActiveProcess instance using the specified properties.
         * @param [properties] Properties to set
         * @returns ActiveProcess instance
         */
        public static create(properties?: product.IActiveProcess): product.ActiveProcess;

        /**
         * Encodes the specified ActiveProcess message. Does not implicitly {@link product.ActiveProcess.verify|verify} messages.
         * @param message ActiveProcess message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.IActiveProcess, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified ActiveProcess message, length delimited. Does not implicitly {@link product.ActiveProcess.verify|verify} messages.
         * @param message ActiveProcess message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.IActiveProcess, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes an ActiveProcess message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns ActiveProcess
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.ActiveProcess;

        /**
         * Decodes an ActiveProcess message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns ActiveProcess
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.ActiveProcess;

        /**
         * Verifies an ActiveProcess message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates an ActiveProcess message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns ActiveProcess
         */
        public static fromObject(object: { [k: string]: any }): product.ActiveProcess;

        /**
         * Creates a plain object from an ActiveProcess message. Also converts values to other types if specified.
         * @param message ActiveProcess
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.ActiveProcess, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this ActiveProcess to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** Properties of a DownloadSettings. */
    interface IDownloadSettings {

        /** DownloadSettings downloadLimit */
        downloadLimit?: (number|null);

        /** DownloadSettings backfillLimit */
        backfillLimit?: (number|null);
    }

    /** Represents a DownloadSettings. */
    class DownloadSettings implements IDownloadSettings {

        /**
         * Constructs a new DownloadSettings.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.IDownloadSettings);

        /** DownloadSettings downloadLimit. */
        public downloadLimit: number;

        /** DownloadSettings backfillLimit. */
        public backfillLimit: number;

        /**
         * Creates a new DownloadSettings instance using the specified properties.
         * @param [properties] Properties to set
         * @returns DownloadSettings instance
         */
        public static create(properties?: product.IDownloadSettings): product.DownloadSettings;

        /**
         * Encodes the specified DownloadSettings message. Does not implicitly {@link product.DownloadSettings.verify|verify} messages.
         * @param message DownloadSettings message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.IDownloadSettings, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified DownloadSettings message, length delimited. Does not implicitly {@link product.DownloadSettings.verify|verify} messages.
         * @param message DownloadSettings message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.IDownloadSettings, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a DownloadSettings message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns DownloadSettings
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.DownloadSettings;

        /**
         * Decodes a DownloadSettings message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns DownloadSettings
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.DownloadSettings;

        /**
         * Verifies a DownloadSettings message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a DownloadSettings message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns DownloadSettings
         */
        public static fromObject(object: { [k: string]: any }): product.DownloadSettings;

        /**
         * Creates a plain object from a DownloadSettings message. Also converts values to other types if specified.
         * @param message DownloadSettings
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.DownloadSettings, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this DownloadSettings to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** Properties of a ProductDb. */
    interface IProductDb {

        /** ProductDb productInstalls */
        productInstalls?: (product.IProductInstall[]|null);

        /** ProductDb activeInstalls */
        activeInstalls?: (product.IInstallHandshake[]|null);

        /** ProductDb activeProcesses */
        activeProcesses?: (product.IActiveProcess[]|null);

        /** ProductDb productConfigs */
        productConfigs?: (product.IProductConfig[]|null);

        /** ProductDb downloadSettings */
        downloadSettings?: (product.IDownloadSettings|null);
    }

    /** Represents a ProductDb. */
    class ProductDb implements IProductDb {

        /**
         * Constructs a new ProductDb.
         * @param [properties] Properties to set
         */
        constructor(properties?: product.IProductDb);

        /** ProductDb productInstalls. */
        public productInstalls: product.IProductInstall[];

        /** ProductDb activeInstalls. */
        public activeInstalls: product.IInstallHandshake[];

        /** ProductDb activeProcesses. */
        public activeProcesses: product.IActiveProcess[];

        /** ProductDb productConfigs. */
        public productConfigs: product.IProductConfig[];

        /** ProductDb downloadSettings. */
        public downloadSettings?: (product.IDownloadSettings|null);

        /**
         * Creates a new ProductDb instance using the specified properties.
         * @param [properties] Properties to set
         * @returns ProductDb instance
         */
        public static create(properties?: product.IProductDb): product.ProductDb;

        /**
         * Encodes the specified ProductDb message. Does not implicitly {@link product.ProductDb.verify|verify} messages.
         * @param message ProductDb message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encode(message: product.IProductDb, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Encodes the specified ProductDb message, length delimited. Does not implicitly {@link product.ProductDb.verify|verify} messages.
         * @param message ProductDb message or plain object to encode
         * @param [writer] Writer to encode to
         * @returns Writer
         */
        public static encodeDelimited(message: product.IProductDb, writer?: $protobuf.Writer): $protobuf.Writer;

        /**
         * Decodes a ProductDb message from the specified reader or buffer.
         * @param reader Reader or buffer to decode from
         * @param [length] Message length if known beforehand
         * @returns ProductDb
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): product.ProductDb;

        /**
         * Decodes a ProductDb message from the specified reader or buffer, length delimited.
         * @param reader Reader or buffer to decode from
         * @returns ProductDb
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): product.ProductDb;

        /**
         * Verifies a ProductDb message.
         * @param message Plain object to verify
         * @returns `null` if valid, otherwise the reason why it is not
         */
        public static verify(message: { [k: string]: any }): (string|null);

        /**
         * Creates a ProductDb message from a plain object. Also converts values to their respective internal types.
         * @param object Plain object
         * @returns ProductDb
         */
        public static fromObject(object: { [k: string]: any }): product.ProductDb;

        /**
         * Creates a plain object from a ProductDb message. Also converts values to other types if specified.
         * @param message ProductDb
         * @param [options] Conversion options
         * @returns Plain object
         */
        public static toObject(message: product.ProductDb, options?: $protobuf.IConversionOptions): { [k: string]: any };

        /**
         * Converts this ProductDb to JSON.
         * @returns JSON object
         */
        public toJSON(): { [k: string]: any };
    }

    /** LanguageOption enum. */
    enum LanguageOption {
        LANGOPTION_NONE = 0,
        LANGOPTION_TEXT = 1,
        LANGOPTION_SPEECH = 2,
        LANGOPTION_TEXT_AND_SPEECH = 3
    }

    /** LanguageSettingType enum. */
    enum LanguageSettingType {
        LANGSETTING_NONE = 0,
        LANGSETTING_SINGLE = 1,
        LANGSETTING_SIMPLE = 2,
        LANGSETTING_ADVANCED = 3
    }

    /** ShortcutOption enum. */
    enum ShortcutOption {
        SHORTCUT_NONE = 0,
        SHORTCUT_USER = 1,
        SHORTCUT_ALL_USERS = 2
    }

    /** Operation enum. */
    enum Operation {
        OP_UPDATE = 0,
        OP_BACKFILL = 1,
        OP_REPAIR = 2,
        OP_NONE = -1
    }
}
