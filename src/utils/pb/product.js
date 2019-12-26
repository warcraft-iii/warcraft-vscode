/*eslint-disable block-scoped-var, id-length, no-control-regex, no-magic-numbers, no-prototype-builtins, no-redeclare, no-shadow, no-var, sort-vars*/
"use strict";

var $protobuf = require("@apollo/protobufjs/minimal");

// Common aliases
var $Reader = $protobuf.Reader, $Writer = $protobuf.Writer, $util = $protobuf.util;

// Exported root namespace
var $root = $protobuf.roots["default"] || ($protobuf.roots["default"] = {});

$root.product = (function() {

    /**
     * Namespace product.
     * @exports product
     * @namespace
     */
    var product = {};

    product.LanguageSetting = (function() {

        /**
         * Properties of a LanguageSetting.
         * @memberof product
         * @interface ILanguageSetting
         * @property {string|null} [language] LanguageSetting language
         * @property {product.LanguageOption|null} [option] LanguageSetting option
         */

        /**
         * Constructs a new LanguageSetting.
         * @memberof product
         * @classdesc Represents a LanguageSetting.
         * @implements ILanguageSetting
         * @constructor
         * @param {product.ILanguageSetting=} [properties] Properties to set
         */
        function LanguageSetting(properties) {
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * LanguageSetting language.
         * @member {string} language
         * @memberof product.LanguageSetting
         * @instance
         */
        LanguageSetting.prototype.language = "";

        /**
         * LanguageSetting option.
         * @member {product.LanguageOption} option
         * @memberof product.LanguageSetting
         * @instance
         */
        LanguageSetting.prototype.option = 0;

        /**
         * Creates a new LanguageSetting instance using the specified properties.
         * @function create
         * @memberof product.LanguageSetting
         * @static
         * @param {product.ILanguageSetting=} [properties] Properties to set
         * @returns {product.LanguageSetting} LanguageSetting instance
         */
        LanguageSetting.create = function create(properties) {
            return new LanguageSetting(properties);
        };

        /**
         * Encodes the specified LanguageSetting message. Does not implicitly {@link product.LanguageSetting.verify|verify} messages.
         * @function encode
         * @memberof product.LanguageSetting
         * @static
         * @param {product.ILanguageSetting} message LanguageSetting message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        LanguageSetting.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.language != null && Object.hasOwnProperty.call(message, "language"))
                writer.uint32(/* id 1, wireType 2 =*/10).string(message.language);
            if (message.option != null && Object.hasOwnProperty.call(message, "option"))
                writer.uint32(/* id 2, wireType 0 =*/16).int32(message.option);
            return writer;
        };

        /**
         * Encodes the specified LanguageSetting message, length delimited. Does not implicitly {@link product.LanguageSetting.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.LanguageSetting
         * @static
         * @param {product.ILanguageSetting} message LanguageSetting message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        LanguageSetting.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes a LanguageSetting message from the specified reader or buffer.
         * @function decode
         * @memberof product.LanguageSetting
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.LanguageSetting} LanguageSetting
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        LanguageSetting.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.LanguageSetting();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    message.language = reader.string();
                    break;
                case 2:
                    message.option = reader.int32();
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes a LanguageSetting message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.LanguageSetting
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.LanguageSetting} LanguageSetting
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        LanguageSetting.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies a LanguageSetting message.
         * @function verify
         * @memberof product.LanguageSetting
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        LanguageSetting.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.language != null && message.hasOwnProperty("language"))
                if (!$util.isString(message.language))
                    return "language: string expected";
            if (message.option != null && message.hasOwnProperty("option"))
                switch (message.option) {
                default:
                    return "option: enum value expected";
                case 0:
                case 1:
                case 2:
                case 3:
                    break;
                }
            return null;
        };

        /**
         * Creates a LanguageSetting message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.LanguageSetting
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.LanguageSetting} LanguageSetting
         */
        LanguageSetting.fromObject = function fromObject(object) {
            if (object instanceof $root.product.LanguageSetting)
                return object;
            var message = new $root.product.LanguageSetting();
            if (object.language != null)
                message.language = String(object.language);
            switch (object.option) {
            case "LANGOPTION_NONE":
            case 0:
                message.option = 0;
                break;
            case "LANGOPTION_TEXT":
            case 1:
                message.option = 1;
                break;
            case "LANGOPTION_SPEECH":
            case 2:
                message.option = 2;
                break;
            case "LANGOPTION_TEXT_AND_SPEECH":
            case 3:
                message.option = 3;
                break;
            }
            return message;
        };

        /**
         * Creates a plain object from a LanguageSetting message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.LanguageSetting
         * @static
         * @param {product.LanguageSetting} message LanguageSetting
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        LanguageSetting.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.defaults) {
                object.language = "";
                object.option = options.enums === String ? "LANGOPTION_NONE" : 0;
            }
            if (message.language != null && message.hasOwnProperty("language"))
                object.language = message.language;
            if (message.option != null && message.hasOwnProperty("option"))
                object.option = options.enums === String ? $root.product.LanguageOption[message.option] : message.option;
            return object;
        };

        /**
         * Converts this LanguageSetting to JSON.
         * @function toJSON
         * @memberof product.LanguageSetting
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        LanguageSetting.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return LanguageSetting;
    })();

    product.UserSettings = (function() {

        /**
         * Properties of a UserSettings.
         * @memberof product
         * @interface IUserSettings
         * @property {string|null} [installPath] UserSettings installPath
         * @property {string|null} [playRegion] UserSettings playRegion
         * @property {product.ShortcutOption|null} [desktopShortcut] UserSettings desktopShortcut
         * @property {product.ShortcutOption|null} [startmenuShortcut] UserSettings startmenuShortcut
         * @property {product.LanguageSettingType|null} [languageSettings] UserSettings languageSettings
         * @property {string|null} [selectedTextLanguage] UserSettings selectedTextLanguage
         * @property {string|null} [selectedSpeechLanguage] UserSettings selectedSpeechLanguage
         * @property {Array.<product.ILanguageSetting>|null} [languages] UserSettings languages
         * @property {string|null} [gfxOverrideTags] UserSettings gfxOverrideTags
         * @property {string|null} [versionbranch] UserSettings versionbranch
         */

        /**
         * Constructs a new UserSettings.
         * @memberof product
         * @classdesc Represents a UserSettings.
         * @implements IUserSettings
         * @constructor
         * @param {product.IUserSettings=} [properties] Properties to set
         */
        function UserSettings(properties) {
            this.languages = [];
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * UserSettings installPath.
         * @member {string} installPath
         * @memberof product.UserSettings
         * @instance
         */
        UserSettings.prototype.installPath = "";

        /**
         * UserSettings playRegion.
         * @member {string} playRegion
         * @memberof product.UserSettings
         * @instance
         */
        UserSettings.prototype.playRegion = "";

        /**
         * UserSettings desktopShortcut.
         * @member {product.ShortcutOption} desktopShortcut
         * @memberof product.UserSettings
         * @instance
         */
        UserSettings.prototype.desktopShortcut = 0;

        /**
         * UserSettings startmenuShortcut.
         * @member {product.ShortcutOption} startmenuShortcut
         * @memberof product.UserSettings
         * @instance
         */
        UserSettings.prototype.startmenuShortcut = 0;

        /**
         * UserSettings languageSettings.
         * @member {product.LanguageSettingType} languageSettings
         * @memberof product.UserSettings
         * @instance
         */
        UserSettings.prototype.languageSettings = 0;

        /**
         * UserSettings selectedTextLanguage.
         * @member {string} selectedTextLanguage
         * @memberof product.UserSettings
         * @instance
         */
        UserSettings.prototype.selectedTextLanguage = "";

        /**
         * UserSettings selectedSpeechLanguage.
         * @member {string} selectedSpeechLanguage
         * @memberof product.UserSettings
         * @instance
         */
        UserSettings.prototype.selectedSpeechLanguage = "";

        /**
         * UserSettings languages.
         * @member {Array.<product.ILanguageSetting>} languages
         * @memberof product.UserSettings
         * @instance
         */
        UserSettings.prototype.languages = $util.emptyArray;

        /**
         * UserSettings gfxOverrideTags.
         * @member {string} gfxOverrideTags
         * @memberof product.UserSettings
         * @instance
         */
        UserSettings.prototype.gfxOverrideTags = "";

        /**
         * UserSettings versionbranch.
         * @member {string} versionbranch
         * @memberof product.UserSettings
         * @instance
         */
        UserSettings.prototype.versionbranch = "";

        /**
         * Creates a new UserSettings instance using the specified properties.
         * @function create
         * @memberof product.UserSettings
         * @static
         * @param {product.IUserSettings=} [properties] Properties to set
         * @returns {product.UserSettings} UserSettings instance
         */
        UserSettings.create = function create(properties) {
            return new UserSettings(properties);
        };

        /**
         * Encodes the specified UserSettings message. Does not implicitly {@link product.UserSettings.verify|verify} messages.
         * @function encode
         * @memberof product.UserSettings
         * @static
         * @param {product.IUserSettings} message UserSettings message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        UserSettings.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.installPath != null && Object.hasOwnProperty.call(message, "installPath"))
                writer.uint32(/* id 1, wireType 2 =*/10).string(message.installPath);
            if (message.playRegion != null && Object.hasOwnProperty.call(message, "playRegion"))
                writer.uint32(/* id 2, wireType 2 =*/18).string(message.playRegion);
            if (message.desktopShortcut != null && Object.hasOwnProperty.call(message, "desktopShortcut"))
                writer.uint32(/* id 3, wireType 0 =*/24).int32(message.desktopShortcut);
            if (message.startmenuShortcut != null && Object.hasOwnProperty.call(message, "startmenuShortcut"))
                writer.uint32(/* id 4, wireType 0 =*/32).int32(message.startmenuShortcut);
            if (message.languageSettings != null && Object.hasOwnProperty.call(message, "languageSettings"))
                writer.uint32(/* id 5, wireType 0 =*/40).int32(message.languageSettings);
            if (message.selectedTextLanguage != null && Object.hasOwnProperty.call(message, "selectedTextLanguage"))
                writer.uint32(/* id 6, wireType 2 =*/50).string(message.selectedTextLanguage);
            if (message.selectedSpeechLanguage != null && Object.hasOwnProperty.call(message, "selectedSpeechLanguage"))
                writer.uint32(/* id 7, wireType 2 =*/58).string(message.selectedSpeechLanguage);
            if (message.languages != null && message.languages.length)
                for (var i = 0; i < message.languages.length; ++i)
                    $root.product.LanguageSetting.encode(message.languages[i], writer.uint32(/* id 8, wireType 2 =*/66).fork()).ldelim();
            if (message.gfxOverrideTags != null && Object.hasOwnProperty.call(message, "gfxOverrideTags"))
                writer.uint32(/* id 9, wireType 2 =*/74).string(message.gfxOverrideTags);
            if (message.versionbranch != null && Object.hasOwnProperty.call(message, "versionbranch"))
                writer.uint32(/* id 10, wireType 2 =*/82).string(message.versionbranch);
            return writer;
        };

        /**
         * Encodes the specified UserSettings message, length delimited. Does not implicitly {@link product.UserSettings.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.UserSettings
         * @static
         * @param {product.IUserSettings} message UserSettings message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        UserSettings.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes a UserSettings message from the specified reader or buffer.
         * @function decode
         * @memberof product.UserSettings
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.UserSettings} UserSettings
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        UserSettings.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.UserSettings();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    message.installPath = reader.string();
                    break;
                case 2:
                    message.playRegion = reader.string();
                    break;
                case 3:
                    message.desktopShortcut = reader.int32();
                    break;
                case 4:
                    message.startmenuShortcut = reader.int32();
                    break;
                case 5:
                    message.languageSettings = reader.int32();
                    break;
                case 6:
                    message.selectedTextLanguage = reader.string();
                    break;
                case 7:
                    message.selectedSpeechLanguage = reader.string();
                    break;
                case 8:
                    if (!(message.languages && message.languages.length))
                        message.languages = [];
                    message.languages.push($root.product.LanguageSetting.decode(reader, reader.uint32()));
                    break;
                case 9:
                    message.gfxOverrideTags = reader.string();
                    break;
                case 10:
                    message.versionbranch = reader.string();
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes a UserSettings message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.UserSettings
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.UserSettings} UserSettings
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        UserSettings.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies a UserSettings message.
         * @function verify
         * @memberof product.UserSettings
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        UserSettings.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.installPath != null && message.hasOwnProperty("installPath"))
                if (!$util.isString(message.installPath))
                    return "installPath: string expected";
            if (message.playRegion != null && message.hasOwnProperty("playRegion"))
                if (!$util.isString(message.playRegion))
                    return "playRegion: string expected";
            if (message.desktopShortcut != null && message.hasOwnProperty("desktopShortcut"))
                switch (message.desktopShortcut) {
                default:
                    return "desktopShortcut: enum value expected";
                case 0:
                case 1:
                case 2:
                    break;
                }
            if (message.startmenuShortcut != null && message.hasOwnProperty("startmenuShortcut"))
                switch (message.startmenuShortcut) {
                default:
                    return "startmenuShortcut: enum value expected";
                case 0:
                case 1:
                case 2:
                    break;
                }
            if (message.languageSettings != null && message.hasOwnProperty("languageSettings"))
                switch (message.languageSettings) {
                default:
                    return "languageSettings: enum value expected";
                case 0:
                case 1:
                case 2:
                case 3:
                    break;
                }
            if (message.selectedTextLanguage != null && message.hasOwnProperty("selectedTextLanguage"))
                if (!$util.isString(message.selectedTextLanguage))
                    return "selectedTextLanguage: string expected";
            if (message.selectedSpeechLanguage != null && message.hasOwnProperty("selectedSpeechLanguage"))
                if (!$util.isString(message.selectedSpeechLanguage))
                    return "selectedSpeechLanguage: string expected";
            if (message.languages != null && message.hasOwnProperty("languages")) {
                if (!Array.isArray(message.languages))
                    return "languages: array expected";
                for (var i = 0; i < message.languages.length; ++i) {
                    var error = $root.product.LanguageSetting.verify(message.languages[i]);
                    if (error)
                        return "languages." + error;
                }
            }
            if (message.gfxOverrideTags != null && message.hasOwnProperty("gfxOverrideTags"))
                if (!$util.isString(message.gfxOverrideTags))
                    return "gfxOverrideTags: string expected";
            if (message.versionbranch != null && message.hasOwnProperty("versionbranch"))
                if (!$util.isString(message.versionbranch))
                    return "versionbranch: string expected";
            return null;
        };

        /**
         * Creates a UserSettings message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.UserSettings
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.UserSettings} UserSettings
         */
        UserSettings.fromObject = function fromObject(object) {
            if (object instanceof $root.product.UserSettings)
                return object;
            var message = new $root.product.UserSettings();
            if (object.installPath != null)
                message.installPath = String(object.installPath);
            if (object.playRegion != null)
                message.playRegion = String(object.playRegion);
            switch (object.desktopShortcut) {
            case "SHORTCUT_NONE":
            case 0:
                message.desktopShortcut = 0;
                break;
            case "SHORTCUT_USER":
            case 1:
                message.desktopShortcut = 1;
                break;
            case "SHORTCUT_ALL_USERS":
            case 2:
                message.desktopShortcut = 2;
                break;
            }
            switch (object.startmenuShortcut) {
            case "SHORTCUT_NONE":
            case 0:
                message.startmenuShortcut = 0;
                break;
            case "SHORTCUT_USER":
            case 1:
                message.startmenuShortcut = 1;
                break;
            case "SHORTCUT_ALL_USERS":
            case 2:
                message.startmenuShortcut = 2;
                break;
            }
            switch (object.languageSettings) {
            case "LANGSETTING_NONE":
            case 0:
                message.languageSettings = 0;
                break;
            case "LANGSETTING_SINGLE":
            case 1:
                message.languageSettings = 1;
                break;
            case "LANGSETTING_SIMPLE":
            case 2:
                message.languageSettings = 2;
                break;
            case "LANGSETTING_ADVANCED":
            case 3:
                message.languageSettings = 3;
                break;
            }
            if (object.selectedTextLanguage != null)
                message.selectedTextLanguage = String(object.selectedTextLanguage);
            if (object.selectedSpeechLanguage != null)
                message.selectedSpeechLanguage = String(object.selectedSpeechLanguage);
            if (object.languages) {
                if (!Array.isArray(object.languages))
                    throw TypeError(".product.UserSettings.languages: array expected");
                message.languages = [];
                for (var i = 0; i < object.languages.length; ++i) {
                    if (typeof object.languages[i] !== "object")
                        throw TypeError(".product.UserSettings.languages: object expected");
                    message.languages[i] = $root.product.LanguageSetting.fromObject(object.languages[i]);
                }
            }
            if (object.gfxOverrideTags != null)
                message.gfxOverrideTags = String(object.gfxOverrideTags);
            if (object.versionbranch != null)
                message.versionbranch = String(object.versionbranch);
            return message;
        };

        /**
         * Creates a plain object from a UserSettings message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.UserSettings
         * @static
         * @param {product.UserSettings} message UserSettings
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        UserSettings.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.arrays || options.defaults)
                object.languages = [];
            if (options.defaults) {
                object.installPath = "";
                object.playRegion = "";
                object.desktopShortcut = options.enums === String ? "SHORTCUT_NONE" : 0;
                object.startmenuShortcut = options.enums === String ? "SHORTCUT_NONE" : 0;
                object.languageSettings = options.enums === String ? "LANGSETTING_NONE" : 0;
                object.selectedTextLanguage = "";
                object.selectedSpeechLanguage = "";
                object.gfxOverrideTags = "";
                object.versionbranch = "";
            }
            if (message.installPath != null && message.hasOwnProperty("installPath"))
                object.installPath = message.installPath;
            if (message.playRegion != null && message.hasOwnProperty("playRegion"))
                object.playRegion = message.playRegion;
            if (message.desktopShortcut != null && message.hasOwnProperty("desktopShortcut"))
                object.desktopShortcut = options.enums === String ? $root.product.ShortcutOption[message.desktopShortcut] : message.desktopShortcut;
            if (message.startmenuShortcut != null && message.hasOwnProperty("startmenuShortcut"))
                object.startmenuShortcut = options.enums === String ? $root.product.ShortcutOption[message.startmenuShortcut] : message.startmenuShortcut;
            if (message.languageSettings != null && message.hasOwnProperty("languageSettings"))
                object.languageSettings = options.enums === String ? $root.product.LanguageSettingType[message.languageSettings] : message.languageSettings;
            if (message.selectedTextLanguage != null && message.hasOwnProperty("selectedTextLanguage"))
                object.selectedTextLanguage = message.selectedTextLanguage;
            if (message.selectedSpeechLanguage != null && message.hasOwnProperty("selectedSpeechLanguage"))
                object.selectedSpeechLanguage = message.selectedSpeechLanguage;
            if (message.languages && message.languages.length) {
                object.languages = [];
                for (var j = 0; j < message.languages.length; ++j)
                    object.languages[j] = $root.product.LanguageSetting.toObject(message.languages[j], options);
            }
            if (message.gfxOverrideTags != null && message.hasOwnProperty("gfxOverrideTags"))
                object.gfxOverrideTags = message.gfxOverrideTags;
            if (message.versionbranch != null && message.hasOwnProperty("versionbranch"))
                object.versionbranch = message.versionbranch;
            return object;
        };

        /**
         * Converts this UserSettings to JSON.
         * @function toJSON
         * @memberof product.UserSettings
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        UserSettings.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return UserSettings;
    })();

    product.InstallHandshake = (function() {

        /**
         * Properties of an InstallHandshake.
         * @memberof product
         * @interface IInstallHandshake
         * @property {string|null} [product] InstallHandshake product
         * @property {string|null} [uid] InstallHandshake uid
         * @property {product.IUserSettings|null} [settings] InstallHandshake settings
         */

        /**
         * Constructs a new InstallHandshake.
         * @memberof product
         * @classdesc Represents an InstallHandshake.
         * @implements IInstallHandshake
         * @constructor
         * @param {product.IInstallHandshake=} [properties] Properties to set
         */
        function InstallHandshake(properties) {
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * InstallHandshake product.
         * @member {string} product
         * @memberof product.InstallHandshake
         * @instance
         */
        InstallHandshake.prototype.product = "";

        /**
         * InstallHandshake uid.
         * @member {string} uid
         * @memberof product.InstallHandshake
         * @instance
         */
        InstallHandshake.prototype.uid = "";

        /**
         * InstallHandshake settings.
         * @member {product.IUserSettings|null|undefined} settings
         * @memberof product.InstallHandshake
         * @instance
         */
        InstallHandshake.prototype.settings = null;

        /**
         * Creates a new InstallHandshake instance using the specified properties.
         * @function create
         * @memberof product.InstallHandshake
         * @static
         * @param {product.IInstallHandshake=} [properties] Properties to set
         * @returns {product.InstallHandshake} InstallHandshake instance
         */
        InstallHandshake.create = function create(properties) {
            return new InstallHandshake(properties);
        };

        /**
         * Encodes the specified InstallHandshake message. Does not implicitly {@link product.InstallHandshake.verify|verify} messages.
         * @function encode
         * @memberof product.InstallHandshake
         * @static
         * @param {product.IInstallHandshake} message InstallHandshake message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        InstallHandshake.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.product != null && Object.hasOwnProperty.call(message, "product"))
                writer.uint32(/* id 1, wireType 2 =*/10).string(message.product);
            if (message.uid != null && Object.hasOwnProperty.call(message, "uid"))
                writer.uint32(/* id 2, wireType 2 =*/18).string(message.uid);
            if (message.settings != null && Object.hasOwnProperty.call(message, "settings"))
                $root.product.UserSettings.encode(message.settings, writer.uint32(/* id 3, wireType 2 =*/26).fork()).ldelim();
            return writer;
        };

        /**
         * Encodes the specified InstallHandshake message, length delimited. Does not implicitly {@link product.InstallHandshake.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.InstallHandshake
         * @static
         * @param {product.IInstallHandshake} message InstallHandshake message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        InstallHandshake.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes an InstallHandshake message from the specified reader or buffer.
         * @function decode
         * @memberof product.InstallHandshake
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.InstallHandshake} InstallHandshake
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        InstallHandshake.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.InstallHandshake();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    message.product = reader.string();
                    break;
                case 2:
                    message.uid = reader.string();
                    break;
                case 3:
                    message.settings = $root.product.UserSettings.decode(reader, reader.uint32());
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes an InstallHandshake message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.InstallHandshake
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.InstallHandshake} InstallHandshake
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        InstallHandshake.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies an InstallHandshake message.
         * @function verify
         * @memberof product.InstallHandshake
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        InstallHandshake.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.product != null && message.hasOwnProperty("product"))
                if (!$util.isString(message.product))
                    return "product: string expected";
            if (message.uid != null && message.hasOwnProperty("uid"))
                if (!$util.isString(message.uid))
                    return "uid: string expected";
            if (message.settings != null && message.hasOwnProperty("settings")) {
                var error = $root.product.UserSettings.verify(message.settings);
                if (error)
                    return "settings." + error;
            }
            return null;
        };

        /**
         * Creates an InstallHandshake message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.InstallHandshake
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.InstallHandshake} InstallHandshake
         */
        InstallHandshake.fromObject = function fromObject(object) {
            if (object instanceof $root.product.InstallHandshake)
                return object;
            var message = new $root.product.InstallHandshake();
            if (object.product != null)
                message.product = String(object.product);
            if (object.uid != null)
                message.uid = String(object.uid);
            if (object.settings != null) {
                if (typeof object.settings !== "object")
                    throw TypeError(".product.InstallHandshake.settings: object expected");
                message.settings = $root.product.UserSettings.fromObject(object.settings);
            }
            return message;
        };

        /**
         * Creates a plain object from an InstallHandshake message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.InstallHandshake
         * @static
         * @param {product.InstallHandshake} message InstallHandshake
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        InstallHandshake.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.defaults) {
                object.product = "";
                object.uid = "";
                object.settings = null;
            }
            if (message.product != null && message.hasOwnProperty("product"))
                object.product = message.product;
            if (message.uid != null && message.hasOwnProperty("uid"))
                object.uid = message.uid;
            if (message.settings != null && message.hasOwnProperty("settings"))
                object.settings = $root.product.UserSettings.toObject(message.settings, options);
            return object;
        };

        /**
         * Converts this InstallHandshake to JSON.
         * @function toJSON
         * @memberof product.InstallHandshake
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        InstallHandshake.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return InstallHandshake;
    })();

    product.BuildConfig = (function() {

        /**
         * Properties of a BuildConfig.
         * @memberof product
         * @interface IBuildConfig
         * @property {string|null} [region] BuildConfig region
         * @property {string|null} [buildConfig] BuildConfig buildConfig
         */

        /**
         * Constructs a new BuildConfig.
         * @memberof product
         * @classdesc Represents a BuildConfig.
         * @implements IBuildConfig
         * @constructor
         * @param {product.IBuildConfig=} [properties] Properties to set
         */
        function BuildConfig(properties) {
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * BuildConfig region.
         * @member {string} region
         * @memberof product.BuildConfig
         * @instance
         */
        BuildConfig.prototype.region = "";

        /**
         * BuildConfig buildConfig.
         * @member {string} buildConfig
         * @memberof product.BuildConfig
         * @instance
         */
        BuildConfig.prototype.buildConfig = "";

        /**
         * Creates a new BuildConfig instance using the specified properties.
         * @function create
         * @memberof product.BuildConfig
         * @static
         * @param {product.IBuildConfig=} [properties] Properties to set
         * @returns {product.BuildConfig} BuildConfig instance
         */
        BuildConfig.create = function create(properties) {
            return new BuildConfig(properties);
        };

        /**
         * Encodes the specified BuildConfig message. Does not implicitly {@link product.BuildConfig.verify|verify} messages.
         * @function encode
         * @memberof product.BuildConfig
         * @static
         * @param {product.IBuildConfig} message BuildConfig message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        BuildConfig.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.region != null && Object.hasOwnProperty.call(message, "region"))
                writer.uint32(/* id 1, wireType 2 =*/10).string(message.region);
            if (message.buildConfig != null && Object.hasOwnProperty.call(message, "buildConfig"))
                writer.uint32(/* id 2, wireType 2 =*/18).string(message.buildConfig);
            return writer;
        };

        /**
         * Encodes the specified BuildConfig message, length delimited. Does not implicitly {@link product.BuildConfig.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.BuildConfig
         * @static
         * @param {product.IBuildConfig} message BuildConfig message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        BuildConfig.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes a BuildConfig message from the specified reader or buffer.
         * @function decode
         * @memberof product.BuildConfig
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.BuildConfig} BuildConfig
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        BuildConfig.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.BuildConfig();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    message.region = reader.string();
                    break;
                case 2:
                    message.buildConfig = reader.string();
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes a BuildConfig message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.BuildConfig
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.BuildConfig} BuildConfig
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        BuildConfig.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies a BuildConfig message.
         * @function verify
         * @memberof product.BuildConfig
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        BuildConfig.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.region != null && message.hasOwnProperty("region"))
                if (!$util.isString(message.region))
                    return "region: string expected";
            if (message.buildConfig != null && message.hasOwnProperty("buildConfig"))
                if (!$util.isString(message.buildConfig))
                    return "buildConfig: string expected";
            return null;
        };

        /**
         * Creates a BuildConfig message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.BuildConfig
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.BuildConfig} BuildConfig
         */
        BuildConfig.fromObject = function fromObject(object) {
            if (object instanceof $root.product.BuildConfig)
                return object;
            var message = new $root.product.BuildConfig();
            if (object.region != null)
                message.region = String(object.region);
            if (object.buildConfig != null)
                message.buildConfig = String(object.buildConfig);
            return message;
        };

        /**
         * Creates a plain object from a BuildConfig message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.BuildConfig
         * @static
         * @param {product.BuildConfig} message BuildConfig
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        BuildConfig.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.defaults) {
                object.region = "";
                object.buildConfig = "";
            }
            if (message.region != null && message.hasOwnProperty("region"))
                object.region = message.region;
            if (message.buildConfig != null && message.hasOwnProperty("buildConfig"))
                object.buildConfig = message.buildConfig;
            return object;
        };

        /**
         * Converts this BuildConfig to JSON.
         * @function toJSON
         * @memberof product.BuildConfig
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        BuildConfig.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return BuildConfig;
    })();

    product.BaseProductState = (function() {

        /**
         * Properties of a BaseProductState.
         * @memberof product
         * @interface IBaseProductState
         * @property {boolean|null} [installed] BaseProductState installed
         * @property {boolean|null} [playable] BaseProductState playable
         * @property {boolean|null} [updateComplete] BaseProductState updateComplete
         * @property {boolean|null} [backgroundDownloadAvailable] BaseProductState backgroundDownloadAvailable
         * @property {boolean|null} [backgroundDownloadComplete] BaseProductState backgroundDownloadComplete
         * @property {string|null} [currentVersion] BaseProductState currentVersion
         * @property {string|null} [currentVersionStr] BaseProductState currentVersionStr
         * @property {Array.<product.IBuildConfig>|null} [installedBuildConfig] BaseProductState installedBuildConfig
         * @property {Array.<product.IBuildConfig>|null} [backgroundDownloadBuildConfig] BaseProductState backgroundDownloadBuildConfig
         * @property {string|null} [decryptionKey] BaseProductState decryptionKey
         * @property {Array.<string>|null} [completedInstallActions] BaseProductState completedInstallActions
         */

        /**
         * Constructs a new BaseProductState.
         * @memberof product
         * @classdesc Represents a BaseProductState.
         * @implements IBaseProductState
         * @constructor
         * @param {product.IBaseProductState=} [properties] Properties to set
         */
        function BaseProductState(properties) {
            this.installedBuildConfig = [];
            this.backgroundDownloadBuildConfig = [];
            this.completedInstallActions = [];
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * BaseProductState installed.
         * @member {boolean} installed
         * @memberof product.BaseProductState
         * @instance
         */
        BaseProductState.prototype.installed = false;

        /**
         * BaseProductState playable.
         * @member {boolean} playable
         * @memberof product.BaseProductState
         * @instance
         */
        BaseProductState.prototype.playable = false;

        /**
         * BaseProductState updateComplete.
         * @member {boolean} updateComplete
         * @memberof product.BaseProductState
         * @instance
         */
        BaseProductState.prototype.updateComplete = false;

        /**
         * BaseProductState backgroundDownloadAvailable.
         * @member {boolean} backgroundDownloadAvailable
         * @memberof product.BaseProductState
         * @instance
         */
        BaseProductState.prototype.backgroundDownloadAvailable = false;

        /**
         * BaseProductState backgroundDownloadComplete.
         * @member {boolean} backgroundDownloadComplete
         * @memberof product.BaseProductState
         * @instance
         */
        BaseProductState.prototype.backgroundDownloadComplete = false;

        /**
         * BaseProductState currentVersion.
         * @member {string} currentVersion
         * @memberof product.BaseProductState
         * @instance
         */
        BaseProductState.prototype.currentVersion = "";

        /**
         * BaseProductState currentVersionStr.
         * @member {string} currentVersionStr
         * @memberof product.BaseProductState
         * @instance
         */
        BaseProductState.prototype.currentVersionStr = "";

        /**
         * BaseProductState installedBuildConfig.
         * @member {Array.<product.IBuildConfig>} installedBuildConfig
         * @memberof product.BaseProductState
         * @instance
         */
        BaseProductState.prototype.installedBuildConfig = $util.emptyArray;

        /**
         * BaseProductState backgroundDownloadBuildConfig.
         * @member {Array.<product.IBuildConfig>} backgroundDownloadBuildConfig
         * @memberof product.BaseProductState
         * @instance
         */
        BaseProductState.prototype.backgroundDownloadBuildConfig = $util.emptyArray;

        /**
         * BaseProductState decryptionKey.
         * @member {string} decryptionKey
         * @memberof product.BaseProductState
         * @instance
         */
        BaseProductState.prototype.decryptionKey = "";

        /**
         * BaseProductState completedInstallActions.
         * @member {Array.<string>} completedInstallActions
         * @memberof product.BaseProductState
         * @instance
         */
        BaseProductState.prototype.completedInstallActions = $util.emptyArray;

        /**
         * Creates a new BaseProductState instance using the specified properties.
         * @function create
         * @memberof product.BaseProductState
         * @static
         * @param {product.IBaseProductState=} [properties] Properties to set
         * @returns {product.BaseProductState} BaseProductState instance
         */
        BaseProductState.create = function create(properties) {
            return new BaseProductState(properties);
        };

        /**
         * Encodes the specified BaseProductState message. Does not implicitly {@link product.BaseProductState.verify|verify} messages.
         * @function encode
         * @memberof product.BaseProductState
         * @static
         * @param {product.IBaseProductState} message BaseProductState message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        BaseProductState.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.installed != null && Object.hasOwnProperty.call(message, "installed"))
                writer.uint32(/* id 1, wireType 0 =*/8).bool(message.installed);
            if (message.playable != null && Object.hasOwnProperty.call(message, "playable"))
                writer.uint32(/* id 2, wireType 0 =*/16).bool(message.playable);
            if (message.updateComplete != null && Object.hasOwnProperty.call(message, "updateComplete"))
                writer.uint32(/* id 3, wireType 0 =*/24).bool(message.updateComplete);
            if (message.backgroundDownloadAvailable != null && Object.hasOwnProperty.call(message, "backgroundDownloadAvailable"))
                writer.uint32(/* id 4, wireType 0 =*/32).bool(message.backgroundDownloadAvailable);
            if (message.backgroundDownloadComplete != null && Object.hasOwnProperty.call(message, "backgroundDownloadComplete"))
                writer.uint32(/* id 5, wireType 0 =*/40).bool(message.backgroundDownloadComplete);
            if (message.currentVersion != null && Object.hasOwnProperty.call(message, "currentVersion"))
                writer.uint32(/* id 6, wireType 2 =*/50).string(message.currentVersion);
            if (message.currentVersionStr != null && Object.hasOwnProperty.call(message, "currentVersionStr"))
                writer.uint32(/* id 7, wireType 2 =*/58).string(message.currentVersionStr);
            if (message.installedBuildConfig != null && message.installedBuildConfig.length)
                for (var i = 0; i < message.installedBuildConfig.length; ++i)
                    $root.product.BuildConfig.encode(message.installedBuildConfig[i], writer.uint32(/* id 8, wireType 2 =*/66).fork()).ldelim();
            if (message.backgroundDownloadBuildConfig != null && message.backgroundDownloadBuildConfig.length)
                for (var i = 0; i < message.backgroundDownloadBuildConfig.length; ++i)
                    $root.product.BuildConfig.encode(message.backgroundDownloadBuildConfig[i], writer.uint32(/* id 9, wireType 2 =*/74).fork()).ldelim();
            if (message.decryptionKey != null && Object.hasOwnProperty.call(message, "decryptionKey"))
                writer.uint32(/* id 10, wireType 2 =*/82).string(message.decryptionKey);
            if (message.completedInstallActions != null && message.completedInstallActions.length)
                for (var i = 0; i < message.completedInstallActions.length; ++i)
                    writer.uint32(/* id 11, wireType 2 =*/90).string(message.completedInstallActions[i]);
            return writer;
        };

        /**
         * Encodes the specified BaseProductState message, length delimited. Does not implicitly {@link product.BaseProductState.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.BaseProductState
         * @static
         * @param {product.IBaseProductState} message BaseProductState message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        BaseProductState.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes a BaseProductState message from the specified reader or buffer.
         * @function decode
         * @memberof product.BaseProductState
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.BaseProductState} BaseProductState
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        BaseProductState.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.BaseProductState();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    message.installed = reader.bool();
                    break;
                case 2:
                    message.playable = reader.bool();
                    break;
                case 3:
                    message.updateComplete = reader.bool();
                    break;
                case 4:
                    message.backgroundDownloadAvailable = reader.bool();
                    break;
                case 5:
                    message.backgroundDownloadComplete = reader.bool();
                    break;
                case 6:
                    message.currentVersion = reader.string();
                    break;
                case 7:
                    message.currentVersionStr = reader.string();
                    break;
                case 8:
                    if (!(message.installedBuildConfig && message.installedBuildConfig.length))
                        message.installedBuildConfig = [];
                    message.installedBuildConfig.push($root.product.BuildConfig.decode(reader, reader.uint32()));
                    break;
                case 9:
                    if (!(message.backgroundDownloadBuildConfig && message.backgroundDownloadBuildConfig.length))
                        message.backgroundDownloadBuildConfig = [];
                    message.backgroundDownloadBuildConfig.push($root.product.BuildConfig.decode(reader, reader.uint32()));
                    break;
                case 10:
                    message.decryptionKey = reader.string();
                    break;
                case 11:
                    if (!(message.completedInstallActions && message.completedInstallActions.length))
                        message.completedInstallActions = [];
                    message.completedInstallActions.push(reader.string());
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes a BaseProductState message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.BaseProductState
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.BaseProductState} BaseProductState
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        BaseProductState.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies a BaseProductState message.
         * @function verify
         * @memberof product.BaseProductState
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        BaseProductState.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.installed != null && message.hasOwnProperty("installed"))
                if (typeof message.installed !== "boolean")
                    return "installed: boolean expected";
            if (message.playable != null && message.hasOwnProperty("playable"))
                if (typeof message.playable !== "boolean")
                    return "playable: boolean expected";
            if (message.updateComplete != null && message.hasOwnProperty("updateComplete"))
                if (typeof message.updateComplete !== "boolean")
                    return "updateComplete: boolean expected";
            if (message.backgroundDownloadAvailable != null && message.hasOwnProperty("backgroundDownloadAvailable"))
                if (typeof message.backgroundDownloadAvailable !== "boolean")
                    return "backgroundDownloadAvailable: boolean expected";
            if (message.backgroundDownloadComplete != null && message.hasOwnProperty("backgroundDownloadComplete"))
                if (typeof message.backgroundDownloadComplete !== "boolean")
                    return "backgroundDownloadComplete: boolean expected";
            if (message.currentVersion != null && message.hasOwnProperty("currentVersion"))
                if (!$util.isString(message.currentVersion))
                    return "currentVersion: string expected";
            if (message.currentVersionStr != null && message.hasOwnProperty("currentVersionStr"))
                if (!$util.isString(message.currentVersionStr))
                    return "currentVersionStr: string expected";
            if (message.installedBuildConfig != null && message.hasOwnProperty("installedBuildConfig")) {
                if (!Array.isArray(message.installedBuildConfig))
                    return "installedBuildConfig: array expected";
                for (var i = 0; i < message.installedBuildConfig.length; ++i) {
                    var error = $root.product.BuildConfig.verify(message.installedBuildConfig[i]);
                    if (error)
                        return "installedBuildConfig." + error;
                }
            }
            if (message.backgroundDownloadBuildConfig != null && message.hasOwnProperty("backgroundDownloadBuildConfig")) {
                if (!Array.isArray(message.backgroundDownloadBuildConfig))
                    return "backgroundDownloadBuildConfig: array expected";
                for (var i = 0; i < message.backgroundDownloadBuildConfig.length; ++i) {
                    var error = $root.product.BuildConfig.verify(message.backgroundDownloadBuildConfig[i]);
                    if (error)
                        return "backgroundDownloadBuildConfig." + error;
                }
            }
            if (message.decryptionKey != null && message.hasOwnProperty("decryptionKey"))
                if (!$util.isString(message.decryptionKey))
                    return "decryptionKey: string expected";
            if (message.completedInstallActions != null && message.hasOwnProperty("completedInstallActions")) {
                if (!Array.isArray(message.completedInstallActions))
                    return "completedInstallActions: array expected";
                for (var i = 0; i < message.completedInstallActions.length; ++i)
                    if (!$util.isString(message.completedInstallActions[i]))
                        return "completedInstallActions: string[] expected";
            }
            return null;
        };

        /**
         * Creates a BaseProductState message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.BaseProductState
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.BaseProductState} BaseProductState
         */
        BaseProductState.fromObject = function fromObject(object) {
            if (object instanceof $root.product.BaseProductState)
                return object;
            var message = new $root.product.BaseProductState();
            if (object.installed != null)
                message.installed = Boolean(object.installed);
            if (object.playable != null)
                message.playable = Boolean(object.playable);
            if (object.updateComplete != null)
                message.updateComplete = Boolean(object.updateComplete);
            if (object.backgroundDownloadAvailable != null)
                message.backgroundDownloadAvailable = Boolean(object.backgroundDownloadAvailable);
            if (object.backgroundDownloadComplete != null)
                message.backgroundDownloadComplete = Boolean(object.backgroundDownloadComplete);
            if (object.currentVersion != null)
                message.currentVersion = String(object.currentVersion);
            if (object.currentVersionStr != null)
                message.currentVersionStr = String(object.currentVersionStr);
            if (object.installedBuildConfig) {
                if (!Array.isArray(object.installedBuildConfig))
                    throw TypeError(".product.BaseProductState.installedBuildConfig: array expected");
                message.installedBuildConfig = [];
                for (var i = 0; i < object.installedBuildConfig.length; ++i) {
                    if (typeof object.installedBuildConfig[i] !== "object")
                        throw TypeError(".product.BaseProductState.installedBuildConfig: object expected");
                    message.installedBuildConfig[i] = $root.product.BuildConfig.fromObject(object.installedBuildConfig[i]);
                }
            }
            if (object.backgroundDownloadBuildConfig) {
                if (!Array.isArray(object.backgroundDownloadBuildConfig))
                    throw TypeError(".product.BaseProductState.backgroundDownloadBuildConfig: array expected");
                message.backgroundDownloadBuildConfig = [];
                for (var i = 0; i < object.backgroundDownloadBuildConfig.length; ++i) {
                    if (typeof object.backgroundDownloadBuildConfig[i] !== "object")
                        throw TypeError(".product.BaseProductState.backgroundDownloadBuildConfig: object expected");
                    message.backgroundDownloadBuildConfig[i] = $root.product.BuildConfig.fromObject(object.backgroundDownloadBuildConfig[i]);
                }
            }
            if (object.decryptionKey != null)
                message.decryptionKey = String(object.decryptionKey);
            if (object.completedInstallActions) {
                if (!Array.isArray(object.completedInstallActions))
                    throw TypeError(".product.BaseProductState.completedInstallActions: array expected");
                message.completedInstallActions = [];
                for (var i = 0; i < object.completedInstallActions.length; ++i)
                    message.completedInstallActions[i] = String(object.completedInstallActions[i]);
            }
            return message;
        };

        /**
         * Creates a plain object from a BaseProductState message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.BaseProductState
         * @static
         * @param {product.BaseProductState} message BaseProductState
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        BaseProductState.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.arrays || options.defaults) {
                object.installedBuildConfig = [];
                object.backgroundDownloadBuildConfig = [];
                object.completedInstallActions = [];
            }
            if (options.defaults) {
                object.installed = false;
                object.playable = false;
                object.updateComplete = false;
                object.backgroundDownloadAvailable = false;
                object.backgroundDownloadComplete = false;
                object.currentVersion = "";
                object.currentVersionStr = "";
                object.decryptionKey = "";
            }
            if (message.installed != null && message.hasOwnProperty("installed"))
                object.installed = message.installed;
            if (message.playable != null && message.hasOwnProperty("playable"))
                object.playable = message.playable;
            if (message.updateComplete != null && message.hasOwnProperty("updateComplete"))
                object.updateComplete = message.updateComplete;
            if (message.backgroundDownloadAvailable != null && message.hasOwnProperty("backgroundDownloadAvailable"))
                object.backgroundDownloadAvailable = message.backgroundDownloadAvailable;
            if (message.backgroundDownloadComplete != null && message.hasOwnProperty("backgroundDownloadComplete"))
                object.backgroundDownloadComplete = message.backgroundDownloadComplete;
            if (message.currentVersion != null && message.hasOwnProperty("currentVersion"))
                object.currentVersion = message.currentVersion;
            if (message.currentVersionStr != null && message.hasOwnProperty("currentVersionStr"))
                object.currentVersionStr = message.currentVersionStr;
            if (message.installedBuildConfig && message.installedBuildConfig.length) {
                object.installedBuildConfig = [];
                for (var j = 0; j < message.installedBuildConfig.length; ++j)
                    object.installedBuildConfig[j] = $root.product.BuildConfig.toObject(message.installedBuildConfig[j], options);
            }
            if (message.backgroundDownloadBuildConfig && message.backgroundDownloadBuildConfig.length) {
                object.backgroundDownloadBuildConfig = [];
                for (var j = 0; j < message.backgroundDownloadBuildConfig.length; ++j)
                    object.backgroundDownloadBuildConfig[j] = $root.product.BuildConfig.toObject(message.backgroundDownloadBuildConfig[j], options);
            }
            if (message.decryptionKey != null && message.hasOwnProperty("decryptionKey"))
                object.decryptionKey = message.decryptionKey;
            if (message.completedInstallActions && message.completedInstallActions.length) {
                object.completedInstallActions = [];
                for (var j = 0; j < message.completedInstallActions.length; ++j)
                    object.completedInstallActions[j] = message.completedInstallActions[j];
            }
            return object;
        };

        /**
         * Converts this BaseProductState to JSON.
         * @function toJSON
         * @memberof product.BaseProductState
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        BaseProductState.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return BaseProductState;
    })();

    product.BackfillProgress = (function() {

        /**
         * Properties of a BackfillProgress.
         * @memberof product
         * @interface IBackfillProgress
         * @property {number|null} [progress] BackfillProgress progress
         * @property {boolean|null} [backgrounddownload] BackfillProgress backgrounddownload
         * @property {boolean|null} [paused] BackfillProgress paused
         * @property {number|Long|null} [downloadLimit] BackfillProgress downloadLimit
         */

        /**
         * Constructs a new BackfillProgress.
         * @memberof product
         * @classdesc Represents a BackfillProgress.
         * @implements IBackfillProgress
         * @constructor
         * @param {product.IBackfillProgress=} [properties] Properties to set
         */
        function BackfillProgress(properties) {
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * BackfillProgress progress.
         * @member {number} progress
         * @memberof product.BackfillProgress
         * @instance
         */
        BackfillProgress.prototype.progress = 0;

        /**
         * BackfillProgress backgrounddownload.
         * @member {boolean} backgrounddownload
         * @memberof product.BackfillProgress
         * @instance
         */
        BackfillProgress.prototype.backgrounddownload = false;

        /**
         * BackfillProgress paused.
         * @member {boolean} paused
         * @memberof product.BackfillProgress
         * @instance
         */
        BackfillProgress.prototype.paused = false;

        /**
         * BackfillProgress downloadLimit.
         * @member {number|Long} downloadLimit
         * @memberof product.BackfillProgress
         * @instance
         */
        BackfillProgress.prototype.downloadLimit = $util.Long ? $util.Long.fromBits(0,0,true) : 0;

        /**
         * Creates a new BackfillProgress instance using the specified properties.
         * @function create
         * @memberof product.BackfillProgress
         * @static
         * @param {product.IBackfillProgress=} [properties] Properties to set
         * @returns {product.BackfillProgress} BackfillProgress instance
         */
        BackfillProgress.create = function create(properties) {
            return new BackfillProgress(properties);
        };

        /**
         * Encodes the specified BackfillProgress message. Does not implicitly {@link product.BackfillProgress.verify|verify} messages.
         * @function encode
         * @memberof product.BackfillProgress
         * @static
         * @param {product.IBackfillProgress} message BackfillProgress message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        BackfillProgress.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.progress != null && Object.hasOwnProperty.call(message, "progress"))
                writer.uint32(/* id 1, wireType 1 =*/9).double(message.progress);
            if (message.backgrounddownload != null && Object.hasOwnProperty.call(message, "backgrounddownload"))
                writer.uint32(/* id 2, wireType 0 =*/16).bool(message.backgrounddownload);
            if (message.paused != null && Object.hasOwnProperty.call(message, "paused"))
                writer.uint32(/* id 3, wireType 0 =*/24).bool(message.paused);
            if (message.downloadLimit != null && Object.hasOwnProperty.call(message, "downloadLimit"))
                writer.uint32(/* id 4, wireType 0 =*/32).uint64(message.downloadLimit);
            return writer;
        };

        /**
         * Encodes the specified BackfillProgress message, length delimited. Does not implicitly {@link product.BackfillProgress.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.BackfillProgress
         * @static
         * @param {product.IBackfillProgress} message BackfillProgress message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        BackfillProgress.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes a BackfillProgress message from the specified reader or buffer.
         * @function decode
         * @memberof product.BackfillProgress
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.BackfillProgress} BackfillProgress
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        BackfillProgress.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.BackfillProgress();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    message.progress = reader.double();
                    break;
                case 2:
                    message.backgrounddownload = reader.bool();
                    break;
                case 3:
                    message.paused = reader.bool();
                    break;
                case 4:
                    message.downloadLimit = reader.uint64();
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes a BackfillProgress message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.BackfillProgress
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.BackfillProgress} BackfillProgress
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        BackfillProgress.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies a BackfillProgress message.
         * @function verify
         * @memberof product.BackfillProgress
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        BackfillProgress.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.progress != null && message.hasOwnProperty("progress"))
                if (typeof message.progress !== "number")
                    return "progress: number expected";
            if (message.backgrounddownload != null && message.hasOwnProperty("backgrounddownload"))
                if (typeof message.backgrounddownload !== "boolean")
                    return "backgrounddownload: boolean expected";
            if (message.paused != null && message.hasOwnProperty("paused"))
                if (typeof message.paused !== "boolean")
                    return "paused: boolean expected";
            if (message.downloadLimit != null && message.hasOwnProperty("downloadLimit"))
                if (!$util.isInteger(message.downloadLimit) && !(message.downloadLimit && $util.isInteger(message.downloadLimit.low) && $util.isInteger(message.downloadLimit.high)))
                    return "downloadLimit: integer|Long expected";
            return null;
        };

        /**
         * Creates a BackfillProgress message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.BackfillProgress
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.BackfillProgress} BackfillProgress
         */
        BackfillProgress.fromObject = function fromObject(object) {
            if (object instanceof $root.product.BackfillProgress)
                return object;
            var message = new $root.product.BackfillProgress();
            if (object.progress != null)
                message.progress = Number(object.progress);
            if (object.backgrounddownload != null)
                message.backgrounddownload = Boolean(object.backgrounddownload);
            if (object.paused != null)
                message.paused = Boolean(object.paused);
            if (object.downloadLimit != null)
                if ($util.Long)
                    (message.downloadLimit = $util.Long.fromValue(object.downloadLimit)).unsigned = true;
                else if (typeof object.downloadLimit === "string")
                    message.downloadLimit = parseInt(object.downloadLimit, 10);
                else if (typeof object.downloadLimit === "number")
                    message.downloadLimit = object.downloadLimit;
                else if (typeof object.downloadLimit === "object")
                    message.downloadLimit = new $util.LongBits(object.downloadLimit.low >>> 0, object.downloadLimit.high >>> 0).toNumber(true);
            return message;
        };

        /**
         * Creates a plain object from a BackfillProgress message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.BackfillProgress
         * @static
         * @param {product.BackfillProgress} message BackfillProgress
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        BackfillProgress.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.defaults) {
                object.progress = 0;
                object.backgrounddownload = false;
                object.paused = false;
                if ($util.Long) {
                    var long = new $util.Long(0, 0, true);
                    object.downloadLimit = options.longs === String ? long.toString() : options.longs === Number ? long.toNumber() : long;
                } else
                    object.downloadLimit = options.longs === String ? "0" : 0;
            }
            if (message.progress != null && message.hasOwnProperty("progress"))
                object.progress = options.json && !isFinite(message.progress) ? String(message.progress) : message.progress;
            if (message.backgrounddownload != null && message.hasOwnProperty("backgrounddownload"))
                object.backgrounddownload = message.backgrounddownload;
            if (message.paused != null && message.hasOwnProperty("paused"))
                object.paused = message.paused;
            if (message.downloadLimit != null && message.hasOwnProperty("downloadLimit"))
                if (typeof message.downloadLimit === "number")
                    object.downloadLimit = options.longs === String ? String(message.downloadLimit) : message.downloadLimit;
                else
                    object.downloadLimit = options.longs === String ? $util.Long.prototype.toString.call(message.downloadLimit) : options.longs === Number ? new $util.LongBits(message.downloadLimit.low >>> 0, message.downloadLimit.high >>> 0).toNumber(true) : message.downloadLimit;
            return object;
        };

        /**
         * Converts this BackfillProgress to JSON.
         * @function toJSON
         * @memberof product.BackfillProgress
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        BackfillProgress.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return BackfillProgress;
    })();

    product.RepairProgress = (function() {

        /**
         * Properties of a RepairProgress.
         * @memberof product
         * @interface IRepairProgress
         * @property {number|null} [progress] RepairProgress progress
         */

        /**
         * Constructs a new RepairProgress.
         * @memberof product
         * @classdesc Represents a RepairProgress.
         * @implements IRepairProgress
         * @constructor
         * @param {product.IRepairProgress=} [properties] Properties to set
         */
        function RepairProgress(properties) {
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * RepairProgress progress.
         * @member {number} progress
         * @memberof product.RepairProgress
         * @instance
         */
        RepairProgress.prototype.progress = 0;

        /**
         * Creates a new RepairProgress instance using the specified properties.
         * @function create
         * @memberof product.RepairProgress
         * @static
         * @param {product.IRepairProgress=} [properties] Properties to set
         * @returns {product.RepairProgress} RepairProgress instance
         */
        RepairProgress.create = function create(properties) {
            return new RepairProgress(properties);
        };

        /**
         * Encodes the specified RepairProgress message. Does not implicitly {@link product.RepairProgress.verify|verify} messages.
         * @function encode
         * @memberof product.RepairProgress
         * @static
         * @param {product.IRepairProgress} message RepairProgress message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        RepairProgress.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.progress != null && Object.hasOwnProperty.call(message, "progress"))
                writer.uint32(/* id 1, wireType 1 =*/9).double(message.progress);
            return writer;
        };

        /**
         * Encodes the specified RepairProgress message, length delimited. Does not implicitly {@link product.RepairProgress.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.RepairProgress
         * @static
         * @param {product.IRepairProgress} message RepairProgress message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        RepairProgress.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes a RepairProgress message from the specified reader or buffer.
         * @function decode
         * @memberof product.RepairProgress
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.RepairProgress} RepairProgress
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        RepairProgress.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.RepairProgress();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    message.progress = reader.double();
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes a RepairProgress message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.RepairProgress
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.RepairProgress} RepairProgress
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        RepairProgress.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies a RepairProgress message.
         * @function verify
         * @memberof product.RepairProgress
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        RepairProgress.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.progress != null && message.hasOwnProperty("progress"))
                if (typeof message.progress !== "number")
                    return "progress: number expected";
            return null;
        };

        /**
         * Creates a RepairProgress message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.RepairProgress
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.RepairProgress} RepairProgress
         */
        RepairProgress.fromObject = function fromObject(object) {
            if (object instanceof $root.product.RepairProgress)
                return object;
            var message = new $root.product.RepairProgress();
            if (object.progress != null)
                message.progress = Number(object.progress);
            return message;
        };

        /**
         * Creates a plain object from a RepairProgress message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.RepairProgress
         * @static
         * @param {product.RepairProgress} message RepairProgress
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        RepairProgress.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.defaults)
                object.progress = 0;
            if (message.progress != null && message.hasOwnProperty("progress"))
                object.progress = options.json && !isFinite(message.progress) ? String(message.progress) : message.progress;
            return object;
        };

        /**
         * Converts this RepairProgress to JSON.
         * @function toJSON
         * @memberof product.RepairProgress
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        RepairProgress.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return RepairProgress;
    })();

    product.UpdateProgress = (function() {

        /**
         * Properties of an UpdateProgress.
         * @memberof product
         * @interface IUpdateProgress
         * @property {string|null} [lastDiscSetUsed] UpdateProgress lastDiscSetUsed
         * @property {number|null} [progress] UpdateProgress progress
         * @property {boolean|null} [discIgnored] UpdateProgress discIgnored
         * @property {number|Long|null} [totalToDownload] UpdateProgress totalToDownload
         * @property {number|Long|null} [downloadRemaining] UpdateProgress downloadRemaining
         */

        /**
         * Constructs a new UpdateProgress.
         * @memberof product
         * @classdesc Represents an UpdateProgress.
         * @implements IUpdateProgress
         * @constructor
         * @param {product.IUpdateProgress=} [properties] Properties to set
         */
        function UpdateProgress(properties) {
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * UpdateProgress lastDiscSetUsed.
         * @member {string} lastDiscSetUsed
         * @memberof product.UpdateProgress
         * @instance
         */
        UpdateProgress.prototype.lastDiscSetUsed = "";

        /**
         * UpdateProgress progress.
         * @member {number} progress
         * @memberof product.UpdateProgress
         * @instance
         */
        UpdateProgress.prototype.progress = 0;

        /**
         * UpdateProgress discIgnored.
         * @member {boolean} discIgnored
         * @memberof product.UpdateProgress
         * @instance
         */
        UpdateProgress.prototype.discIgnored = false;

        /**
         * UpdateProgress totalToDownload.
         * @member {number|Long} totalToDownload
         * @memberof product.UpdateProgress
         * @instance
         */
        UpdateProgress.prototype.totalToDownload = $util.Long ? $util.Long.fromBits(0,0,true) : 0;

        /**
         * UpdateProgress downloadRemaining.
         * @member {number|Long} downloadRemaining
         * @memberof product.UpdateProgress
         * @instance
         */
        UpdateProgress.prototype.downloadRemaining = $util.Long ? $util.Long.fromBits(0,0,true) : 0;

        /**
         * Creates a new UpdateProgress instance using the specified properties.
         * @function create
         * @memberof product.UpdateProgress
         * @static
         * @param {product.IUpdateProgress=} [properties] Properties to set
         * @returns {product.UpdateProgress} UpdateProgress instance
         */
        UpdateProgress.create = function create(properties) {
            return new UpdateProgress(properties);
        };

        /**
         * Encodes the specified UpdateProgress message. Does not implicitly {@link product.UpdateProgress.verify|verify} messages.
         * @function encode
         * @memberof product.UpdateProgress
         * @static
         * @param {product.IUpdateProgress} message UpdateProgress message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        UpdateProgress.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.lastDiscSetUsed != null && Object.hasOwnProperty.call(message, "lastDiscSetUsed"))
                writer.uint32(/* id 1, wireType 2 =*/10).string(message.lastDiscSetUsed);
            if (message.progress != null && Object.hasOwnProperty.call(message, "progress"))
                writer.uint32(/* id 2, wireType 1 =*/17).double(message.progress);
            if (message.discIgnored != null && Object.hasOwnProperty.call(message, "discIgnored"))
                writer.uint32(/* id 3, wireType 0 =*/24).bool(message.discIgnored);
            if (message.totalToDownload != null && Object.hasOwnProperty.call(message, "totalToDownload"))
                writer.uint32(/* id 4, wireType 0 =*/32).uint64(message.totalToDownload);
            if (message.downloadRemaining != null && Object.hasOwnProperty.call(message, "downloadRemaining"))
                writer.uint32(/* id 5, wireType 0 =*/40).uint64(message.downloadRemaining);
            return writer;
        };

        /**
         * Encodes the specified UpdateProgress message, length delimited. Does not implicitly {@link product.UpdateProgress.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.UpdateProgress
         * @static
         * @param {product.IUpdateProgress} message UpdateProgress message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        UpdateProgress.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes an UpdateProgress message from the specified reader or buffer.
         * @function decode
         * @memberof product.UpdateProgress
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.UpdateProgress} UpdateProgress
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        UpdateProgress.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.UpdateProgress();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    message.lastDiscSetUsed = reader.string();
                    break;
                case 2:
                    message.progress = reader.double();
                    break;
                case 3:
                    message.discIgnored = reader.bool();
                    break;
                case 4:
                    message.totalToDownload = reader.uint64();
                    break;
                case 5:
                    message.downloadRemaining = reader.uint64();
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes an UpdateProgress message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.UpdateProgress
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.UpdateProgress} UpdateProgress
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        UpdateProgress.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies an UpdateProgress message.
         * @function verify
         * @memberof product.UpdateProgress
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        UpdateProgress.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.lastDiscSetUsed != null && message.hasOwnProperty("lastDiscSetUsed"))
                if (!$util.isString(message.lastDiscSetUsed))
                    return "lastDiscSetUsed: string expected";
            if (message.progress != null && message.hasOwnProperty("progress"))
                if (typeof message.progress !== "number")
                    return "progress: number expected";
            if (message.discIgnored != null && message.hasOwnProperty("discIgnored"))
                if (typeof message.discIgnored !== "boolean")
                    return "discIgnored: boolean expected";
            if (message.totalToDownload != null && message.hasOwnProperty("totalToDownload"))
                if (!$util.isInteger(message.totalToDownload) && !(message.totalToDownload && $util.isInteger(message.totalToDownload.low) && $util.isInteger(message.totalToDownload.high)))
                    return "totalToDownload: integer|Long expected";
            if (message.downloadRemaining != null && message.hasOwnProperty("downloadRemaining"))
                if (!$util.isInteger(message.downloadRemaining) && !(message.downloadRemaining && $util.isInteger(message.downloadRemaining.low) && $util.isInteger(message.downloadRemaining.high)))
                    return "downloadRemaining: integer|Long expected";
            return null;
        };

        /**
         * Creates an UpdateProgress message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.UpdateProgress
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.UpdateProgress} UpdateProgress
         */
        UpdateProgress.fromObject = function fromObject(object) {
            if (object instanceof $root.product.UpdateProgress)
                return object;
            var message = new $root.product.UpdateProgress();
            if (object.lastDiscSetUsed != null)
                message.lastDiscSetUsed = String(object.lastDiscSetUsed);
            if (object.progress != null)
                message.progress = Number(object.progress);
            if (object.discIgnored != null)
                message.discIgnored = Boolean(object.discIgnored);
            if (object.totalToDownload != null)
                if ($util.Long)
                    (message.totalToDownload = $util.Long.fromValue(object.totalToDownload)).unsigned = true;
                else if (typeof object.totalToDownload === "string")
                    message.totalToDownload = parseInt(object.totalToDownload, 10);
                else if (typeof object.totalToDownload === "number")
                    message.totalToDownload = object.totalToDownload;
                else if (typeof object.totalToDownload === "object")
                    message.totalToDownload = new $util.LongBits(object.totalToDownload.low >>> 0, object.totalToDownload.high >>> 0).toNumber(true);
            if (object.downloadRemaining != null)
                if ($util.Long)
                    (message.downloadRemaining = $util.Long.fromValue(object.downloadRemaining)).unsigned = true;
                else if (typeof object.downloadRemaining === "string")
                    message.downloadRemaining = parseInt(object.downloadRemaining, 10);
                else if (typeof object.downloadRemaining === "number")
                    message.downloadRemaining = object.downloadRemaining;
                else if (typeof object.downloadRemaining === "object")
                    message.downloadRemaining = new $util.LongBits(object.downloadRemaining.low >>> 0, object.downloadRemaining.high >>> 0).toNumber(true);
            return message;
        };

        /**
         * Creates a plain object from an UpdateProgress message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.UpdateProgress
         * @static
         * @param {product.UpdateProgress} message UpdateProgress
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        UpdateProgress.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.defaults) {
                object.lastDiscSetUsed = "";
                object.progress = 0;
                object.discIgnored = false;
                if ($util.Long) {
                    var long = new $util.Long(0, 0, true);
                    object.totalToDownload = options.longs === String ? long.toString() : options.longs === Number ? long.toNumber() : long;
                } else
                    object.totalToDownload = options.longs === String ? "0" : 0;
                if ($util.Long) {
                    var long = new $util.Long(0, 0, true);
                    object.downloadRemaining = options.longs === String ? long.toString() : options.longs === Number ? long.toNumber() : long;
                } else
                    object.downloadRemaining = options.longs === String ? "0" : 0;
            }
            if (message.lastDiscSetUsed != null && message.hasOwnProperty("lastDiscSetUsed"))
                object.lastDiscSetUsed = message.lastDiscSetUsed;
            if (message.progress != null && message.hasOwnProperty("progress"))
                object.progress = options.json && !isFinite(message.progress) ? String(message.progress) : message.progress;
            if (message.discIgnored != null && message.hasOwnProperty("discIgnored"))
                object.discIgnored = message.discIgnored;
            if (message.totalToDownload != null && message.hasOwnProperty("totalToDownload"))
                if (typeof message.totalToDownload === "number")
                    object.totalToDownload = options.longs === String ? String(message.totalToDownload) : message.totalToDownload;
                else
                    object.totalToDownload = options.longs === String ? $util.Long.prototype.toString.call(message.totalToDownload) : options.longs === Number ? new $util.LongBits(message.totalToDownload.low >>> 0, message.totalToDownload.high >>> 0).toNumber(true) : message.totalToDownload;
            if (message.downloadRemaining != null && message.hasOwnProperty("downloadRemaining"))
                if (typeof message.downloadRemaining === "number")
                    object.downloadRemaining = options.longs === String ? String(message.downloadRemaining) : message.downloadRemaining;
                else
                    object.downloadRemaining = options.longs === String ? $util.Long.prototype.toString.call(message.downloadRemaining) : options.longs === Number ? new $util.LongBits(message.downloadRemaining.low >>> 0, message.downloadRemaining.high >>> 0).toNumber(true) : message.downloadRemaining;
            return object;
        };

        /**
         * Converts this UpdateProgress to JSON.
         * @function toJSON
         * @memberof product.UpdateProgress
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        UpdateProgress.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return UpdateProgress;
    })();

    product.CachedProductState = (function() {

        /**
         * Properties of a CachedProductState.
         * @memberof product
         * @interface ICachedProductState
         * @property {product.IBaseProductState|null} [baseProductState] CachedProductState baseProductState
         * @property {product.IBackfillProgress|null} [backfillProgress] CachedProductState backfillProgress
         * @property {product.IRepairProgress|null} [repairProgress] CachedProductState repairProgress
         * @property {product.IUpdateProgress|null} [updateProgress] CachedProductState updateProgress
         */

        /**
         * Constructs a new CachedProductState.
         * @memberof product
         * @classdesc Represents a CachedProductState.
         * @implements ICachedProductState
         * @constructor
         * @param {product.ICachedProductState=} [properties] Properties to set
         */
        function CachedProductState(properties) {
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * CachedProductState baseProductState.
         * @member {product.IBaseProductState|null|undefined} baseProductState
         * @memberof product.CachedProductState
         * @instance
         */
        CachedProductState.prototype.baseProductState = null;

        /**
         * CachedProductState backfillProgress.
         * @member {product.IBackfillProgress|null|undefined} backfillProgress
         * @memberof product.CachedProductState
         * @instance
         */
        CachedProductState.prototype.backfillProgress = null;

        /**
         * CachedProductState repairProgress.
         * @member {product.IRepairProgress|null|undefined} repairProgress
         * @memberof product.CachedProductState
         * @instance
         */
        CachedProductState.prototype.repairProgress = null;

        /**
         * CachedProductState updateProgress.
         * @member {product.IUpdateProgress|null|undefined} updateProgress
         * @memberof product.CachedProductState
         * @instance
         */
        CachedProductState.prototype.updateProgress = null;

        /**
         * Creates a new CachedProductState instance using the specified properties.
         * @function create
         * @memberof product.CachedProductState
         * @static
         * @param {product.ICachedProductState=} [properties] Properties to set
         * @returns {product.CachedProductState} CachedProductState instance
         */
        CachedProductState.create = function create(properties) {
            return new CachedProductState(properties);
        };

        /**
         * Encodes the specified CachedProductState message. Does not implicitly {@link product.CachedProductState.verify|verify} messages.
         * @function encode
         * @memberof product.CachedProductState
         * @static
         * @param {product.ICachedProductState} message CachedProductState message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        CachedProductState.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.baseProductState != null && Object.hasOwnProperty.call(message, "baseProductState"))
                $root.product.BaseProductState.encode(message.baseProductState, writer.uint32(/* id 1, wireType 2 =*/10).fork()).ldelim();
            if (message.backfillProgress != null && Object.hasOwnProperty.call(message, "backfillProgress"))
                $root.product.BackfillProgress.encode(message.backfillProgress, writer.uint32(/* id 2, wireType 2 =*/18).fork()).ldelim();
            if (message.repairProgress != null && Object.hasOwnProperty.call(message, "repairProgress"))
                $root.product.RepairProgress.encode(message.repairProgress, writer.uint32(/* id 3, wireType 2 =*/26).fork()).ldelim();
            if (message.updateProgress != null && Object.hasOwnProperty.call(message, "updateProgress"))
                $root.product.UpdateProgress.encode(message.updateProgress, writer.uint32(/* id 4, wireType 2 =*/34).fork()).ldelim();
            return writer;
        };

        /**
         * Encodes the specified CachedProductState message, length delimited. Does not implicitly {@link product.CachedProductState.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.CachedProductState
         * @static
         * @param {product.ICachedProductState} message CachedProductState message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        CachedProductState.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes a CachedProductState message from the specified reader or buffer.
         * @function decode
         * @memberof product.CachedProductState
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.CachedProductState} CachedProductState
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        CachedProductState.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.CachedProductState();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    message.baseProductState = $root.product.BaseProductState.decode(reader, reader.uint32());
                    break;
                case 2:
                    message.backfillProgress = $root.product.BackfillProgress.decode(reader, reader.uint32());
                    break;
                case 3:
                    message.repairProgress = $root.product.RepairProgress.decode(reader, reader.uint32());
                    break;
                case 4:
                    message.updateProgress = $root.product.UpdateProgress.decode(reader, reader.uint32());
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes a CachedProductState message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.CachedProductState
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.CachedProductState} CachedProductState
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        CachedProductState.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies a CachedProductState message.
         * @function verify
         * @memberof product.CachedProductState
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        CachedProductState.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.baseProductState != null && message.hasOwnProperty("baseProductState")) {
                var error = $root.product.BaseProductState.verify(message.baseProductState);
                if (error)
                    return "baseProductState." + error;
            }
            if (message.backfillProgress != null && message.hasOwnProperty("backfillProgress")) {
                var error = $root.product.BackfillProgress.verify(message.backfillProgress);
                if (error)
                    return "backfillProgress." + error;
            }
            if (message.repairProgress != null && message.hasOwnProperty("repairProgress")) {
                var error = $root.product.RepairProgress.verify(message.repairProgress);
                if (error)
                    return "repairProgress." + error;
            }
            if (message.updateProgress != null && message.hasOwnProperty("updateProgress")) {
                var error = $root.product.UpdateProgress.verify(message.updateProgress);
                if (error)
                    return "updateProgress." + error;
            }
            return null;
        };

        /**
         * Creates a CachedProductState message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.CachedProductState
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.CachedProductState} CachedProductState
         */
        CachedProductState.fromObject = function fromObject(object) {
            if (object instanceof $root.product.CachedProductState)
                return object;
            var message = new $root.product.CachedProductState();
            if (object.baseProductState != null) {
                if (typeof object.baseProductState !== "object")
                    throw TypeError(".product.CachedProductState.baseProductState: object expected");
                message.baseProductState = $root.product.BaseProductState.fromObject(object.baseProductState);
            }
            if (object.backfillProgress != null) {
                if (typeof object.backfillProgress !== "object")
                    throw TypeError(".product.CachedProductState.backfillProgress: object expected");
                message.backfillProgress = $root.product.BackfillProgress.fromObject(object.backfillProgress);
            }
            if (object.repairProgress != null) {
                if (typeof object.repairProgress !== "object")
                    throw TypeError(".product.CachedProductState.repairProgress: object expected");
                message.repairProgress = $root.product.RepairProgress.fromObject(object.repairProgress);
            }
            if (object.updateProgress != null) {
                if (typeof object.updateProgress !== "object")
                    throw TypeError(".product.CachedProductState.updateProgress: object expected");
                message.updateProgress = $root.product.UpdateProgress.fromObject(object.updateProgress);
            }
            return message;
        };

        /**
         * Creates a plain object from a CachedProductState message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.CachedProductState
         * @static
         * @param {product.CachedProductState} message CachedProductState
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        CachedProductState.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.defaults) {
                object.baseProductState = null;
                object.backfillProgress = null;
                object.repairProgress = null;
                object.updateProgress = null;
            }
            if (message.baseProductState != null && message.hasOwnProperty("baseProductState"))
                object.baseProductState = $root.product.BaseProductState.toObject(message.baseProductState, options);
            if (message.backfillProgress != null && message.hasOwnProperty("backfillProgress"))
                object.backfillProgress = $root.product.BackfillProgress.toObject(message.backfillProgress, options);
            if (message.repairProgress != null && message.hasOwnProperty("repairProgress"))
                object.repairProgress = $root.product.RepairProgress.toObject(message.repairProgress, options);
            if (message.updateProgress != null && message.hasOwnProperty("updateProgress"))
                object.updateProgress = $root.product.UpdateProgress.toObject(message.updateProgress, options);
            return object;
        };

        /**
         * Converts this CachedProductState to JSON.
         * @function toJSON
         * @memberof product.CachedProductState
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        CachedProductState.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return CachedProductState;
    })();

    product.ProductOperations = (function() {

        /**
         * Properties of a ProductOperations.
         * @memberof product
         * @interface IProductOperations
         * @property {product.Operation|null} [activeOperation] ProductOperations activeOperation
         * @property {number|Long|null} [priority] ProductOperations priority
         */

        /**
         * Constructs a new ProductOperations.
         * @memberof product
         * @classdesc Represents a ProductOperations.
         * @implements IProductOperations
         * @constructor
         * @param {product.IProductOperations=} [properties] Properties to set
         */
        function ProductOperations(properties) {
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * ProductOperations activeOperation.
         * @member {product.Operation} activeOperation
         * @memberof product.ProductOperations
         * @instance
         */
        ProductOperations.prototype.activeOperation = 0;

        /**
         * ProductOperations priority.
         * @member {number|Long} priority
         * @memberof product.ProductOperations
         * @instance
         */
        ProductOperations.prototype.priority = $util.Long ? $util.Long.fromBits(0,0,true) : 0;

        /**
         * Creates a new ProductOperations instance using the specified properties.
         * @function create
         * @memberof product.ProductOperations
         * @static
         * @param {product.IProductOperations=} [properties] Properties to set
         * @returns {product.ProductOperations} ProductOperations instance
         */
        ProductOperations.create = function create(properties) {
            return new ProductOperations(properties);
        };

        /**
         * Encodes the specified ProductOperations message. Does not implicitly {@link product.ProductOperations.verify|verify} messages.
         * @function encode
         * @memberof product.ProductOperations
         * @static
         * @param {product.IProductOperations} message ProductOperations message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        ProductOperations.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.activeOperation != null && Object.hasOwnProperty.call(message, "activeOperation"))
                writer.uint32(/* id 1, wireType 0 =*/8).int32(message.activeOperation);
            if (message.priority != null && Object.hasOwnProperty.call(message, "priority"))
                writer.uint32(/* id 2, wireType 0 =*/16).uint64(message.priority);
            return writer;
        };

        /**
         * Encodes the specified ProductOperations message, length delimited. Does not implicitly {@link product.ProductOperations.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.ProductOperations
         * @static
         * @param {product.IProductOperations} message ProductOperations message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        ProductOperations.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes a ProductOperations message from the specified reader or buffer.
         * @function decode
         * @memberof product.ProductOperations
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.ProductOperations} ProductOperations
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        ProductOperations.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.ProductOperations();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    message.activeOperation = reader.int32();
                    break;
                case 2:
                    message.priority = reader.uint64();
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes a ProductOperations message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.ProductOperations
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.ProductOperations} ProductOperations
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        ProductOperations.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies a ProductOperations message.
         * @function verify
         * @memberof product.ProductOperations
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        ProductOperations.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.activeOperation != null && message.hasOwnProperty("activeOperation"))
                switch (message.activeOperation) {
                default:
                    return "activeOperation: enum value expected";
                case 0:
                case 1:
                case 2:
                case -1:
                    break;
                }
            if (message.priority != null && message.hasOwnProperty("priority"))
                if (!$util.isInteger(message.priority) && !(message.priority && $util.isInteger(message.priority.low) && $util.isInteger(message.priority.high)))
                    return "priority: integer|Long expected";
            return null;
        };

        /**
         * Creates a ProductOperations message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.ProductOperations
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.ProductOperations} ProductOperations
         */
        ProductOperations.fromObject = function fromObject(object) {
            if (object instanceof $root.product.ProductOperations)
                return object;
            var message = new $root.product.ProductOperations();
            switch (object.activeOperation) {
            case "OP_UPDATE":
            case 0:
                message.activeOperation = 0;
                break;
            case "OP_BACKFILL":
            case 1:
                message.activeOperation = 1;
                break;
            case "OP_REPAIR":
            case 2:
                message.activeOperation = 2;
                break;
            case "OP_NONE":
            case -1:
                message.activeOperation = -1;
                break;
            }
            if (object.priority != null)
                if ($util.Long)
                    (message.priority = $util.Long.fromValue(object.priority)).unsigned = true;
                else if (typeof object.priority === "string")
                    message.priority = parseInt(object.priority, 10);
                else if (typeof object.priority === "number")
                    message.priority = object.priority;
                else if (typeof object.priority === "object")
                    message.priority = new $util.LongBits(object.priority.low >>> 0, object.priority.high >>> 0).toNumber(true);
            return message;
        };

        /**
         * Creates a plain object from a ProductOperations message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.ProductOperations
         * @static
         * @param {product.ProductOperations} message ProductOperations
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        ProductOperations.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.defaults) {
                object.activeOperation = options.enums === String ? "OP_UPDATE" : 0;
                if ($util.Long) {
                    var long = new $util.Long(0, 0, true);
                    object.priority = options.longs === String ? long.toString() : options.longs === Number ? long.toNumber() : long;
                } else
                    object.priority = options.longs === String ? "0" : 0;
            }
            if (message.activeOperation != null && message.hasOwnProperty("activeOperation"))
                object.activeOperation = options.enums === String ? $root.product.Operation[message.activeOperation] : message.activeOperation;
            if (message.priority != null && message.hasOwnProperty("priority"))
                if (typeof message.priority === "number")
                    object.priority = options.longs === String ? String(message.priority) : message.priority;
                else
                    object.priority = options.longs === String ? $util.Long.prototype.toString.call(message.priority) : options.longs === Number ? new $util.LongBits(message.priority.low >>> 0, message.priority.high >>> 0).toNumber(true) : message.priority;
            return object;
        };

        /**
         * Converts this ProductOperations to JSON.
         * @function toJSON
         * @memberof product.ProductOperations
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        ProductOperations.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return ProductOperations;
    })();

    product.ProductInstall = (function() {

        /**
         * Properties of a ProductInstall.
         * @memberof product
         * @interface IProductInstall
         * @property {string|null} [uid] ProductInstall uid
         * @property {string|null} [productCode] ProductInstall productCode
         * @property {product.IUserSettings|null} [settings] ProductInstall settings
         * @property {product.ICachedProductState|null} [cachedProductState] ProductInstall cachedProductState
         * @property {product.IProductOperations|null} [productOperations] ProductInstall productOperations
         */

        /**
         * Constructs a new ProductInstall.
         * @memberof product
         * @classdesc Represents a ProductInstall.
         * @implements IProductInstall
         * @constructor
         * @param {product.IProductInstall=} [properties] Properties to set
         */
        function ProductInstall(properties) {
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * ProductInstall uid.
         * @member {string} uid
         * @memberof product.ProductInstall
         * @instance
         */
        ProductInstall.prototype.uid = "";

        /**
         * ProductInstall productCode.
         * @member {string} productCode
         * @memberof product.ProductInstall
         * @instance
         */
        ProductInstall.prototype.productCode = "";

        /**
         * ProductInstall settings.
         * @member {product.IUserSettings|null|undefined} settings
         * @memberof product.ProductInstall
         * @instance
         */
        ProductInstall.prototype.settings = null;

        /**
         * ProductInstall cachedProductState.
         * @member {product.ICachedProductState|null|undefined} cachedProductState
         * @memberof product.ProductInstall
         * @instance
         */
        ProductInstall.prototype.cachedProductState = null;

        /**
         * ProductInstall productOperations.
         * @member {product.IProductOperations|null|undefined} productOperations
         * @memberof product.ProductInstall
         * @instance
         */
        ProductInstall.prototype.productOperations = null;

        /**
         * Creates a new ProductInstall instance using the specified properties.
         * @function create
         * @memberof product.ProductInstall
         * @static
         * @param {product.IProductInstall=} [properties] Properties to set
         * @returns {product.ProductInstall} ProductInstall instance
         */
        ProductInstall.create = function create(properties) {
            return new ProductInstall(properties);
        };

        /**
         * Encodes the specified ProductInstall message. Does not implicitly {@link product.ProductInstall.verify|verify} messages.
         * @function encode
         * @memberof product.ProductInstall
         * @static
         * @param {product.IProductInstall} message ProductInstall message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        ProductInstall.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.uid != null && Object.hasOwnProperty.call(message, "uid"))
                writer.uint32(/* id 1, wireType 2 =*/10).string(message.uid);
            if (message.productCode != null && Object.hasOwnProperty.call(message, "productCode"))
                writer.uint32(/* id 2, wireType 2 =*/18).string(message.productCode);
            if (message.settings != null && Object.hasOwnProperty.call(message, "settings"))
                $root.product.UserSettings.encode(message.settings, writer.uint32(/* id 3, wireType 2 =*/26).fork()).ldelim();
            if (message.cachedProductState != null && Object.hasOwnProperty.call(message, "cachedProductState"))
                $root.product.CachedProductState.encode(message.cachedProductState, writer.uint32(/* id 4, wireType 2 =*/34).fork()).ldelim();
            if (message.productOperations != null && Object.hasOwnProperty.call(message, "productOperations"))
                $root.product.ProductOperations.encode(message.productOperations, writer.uint32(/* id 5, wireType 2 =*/42).fork()).ldelim();
            return writer;
        };

        /**
         * Encodes the specified ProductInstall message, length delimited. Does not implicitly {@link product.ProductInstall.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.ProductInstall
         * @static
         * @param {product.IProductInstall} message ProductInstall message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        ProductInstall.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes a ProductInstall message from the specified reader or buffer.
         * @function decode
         * @memberof product.ProductInstall
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.ProductInstall} ProductInstall
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        ProductInstall.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.ProductInstall();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    message.uid = reader.string();
                    break;
                case 2:
                    message.productCode = reader.string();
                    break;
                case 3:
                    message.settings = $root.product.UserSettings.decode(reader, reader.uint32());
                    break;
                case 4:
                    message.cachedProductState = $root.product.CachedProductState.decode(reader, reader.uint32());
                    break;
                case 5:
                    message.productOperations = $root.product.ProductOperations.decode(reader, reader.uint32());
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes a ProductInstall message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.ProductInstall
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.ProductInstall} ProductInstall
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        ProductInstall.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies a ProductInstall message.
         * @function verify
         * @memberof product.ProductInstall
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        ProductInstall.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.uid != null && message.hasOwnProperty("uid"))
                if (!$util.isString(message.uid))
                    return "uid: string expected";
            if (message.productCode != null && message.hasOwnProperty("productCode"))
                if (!$util.isString(message.productCode))
                    return "productCode: string expected";
            if (message.settings != null && message.hasOwnProperty("settings")) {
                var error = $root.product.UserSettings.verify(message.settings);
                if (error)
                    return "settings." + error;
            }
            if (message.cachedProductState != null && message.hasOwnProperty("cachedProductState")) {
                var error = $root.product.CachedProductState.verify(message.cachedProductState);
                if (error)
                    return "cachedProductState." + error;
            }
            if (message.productOperations != null && message.hasOwnProperty("productOperations")) {
                var error = $root.product.ProductOperations.verify(message.productOperations);
                if (error)
                    return "productOperations." + error;
            }
            return null;
        };

        /**
         * Creates a ProductInstall message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.ProductInstall
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.ProductInstall} ProductInstall
         */
        ProductInstall.fromObject = function fromObject(object) {
            if (object instanceof $root.product.ProductInstall)
                return object;
            var message = new $root.product.ProductInstall();
            if (object.uid != null)
                message.uid = String(object.uid);
            if (object.productCode != null)
                message.productCode = String(object.productCode);
            if (object.settings != null) {
                if (typeof object.settings !== "object")
                    throw TypeError(".product.ProductInstall.settings: object expected");
                message.settings = $root.product.UserSettings.fromObject(object.settings);
            }
            if (object.cachedProductState != null) {
                if (typeof object.cachedProductState !== "object")
                    throw TypeError(".product.ProductInstall.cachedProductState: object expected");
                message.cachedProductState = $root.product.CachedProductState.fromObject(object.cachedProductState);
            }
            if (object.productOperations != null) {
                if (typeof object.productOperations !== "object")
                    throw TypeError(".product.ProductInstall.productOperations: object expected");
                message.productOperations = $root.product.ProductOperations.fromObject(object.productOperations);
            }
            return message;
        };

        /**
         * Creates a plain object from a ProductInstall message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.ProductInstall
         * @static
         * @param {product.ProductInstall} message ProductInstall
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        ProductInstall.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.defaults) {
                object.uid = "";
                object.productCode = "";
                object.settings = null;
                object.cachedProductState = null;
                object.productOperations = null;
            }
            if (message.uid != null && message.hasOwnProperty("uid"))
                object.uid = message.uid;
            if (message.productCode != null && message.hasOwnProperty("productCode"))
                object.productCode = message.productCode;
            if (message.settings != null && message.hasOwnProperty("settings"))
                object.settings = $root.product.UserSettings.toObject(message.settings, options);
            if (message.cachedProductState != null && message.hasOwnProperty("cachedProductState"))
                object.cachedProductState = $root.product.CachedProductState.toObject(message.cachedProductState, options);
            if (message.productOperations != null && message.hasOwnProperty("productOperations"))
                object.productOperations = $root.product.ProductOperations.toObject(message.productOperations, options);
            return object;
        };

        /**
         * Converts this ProductInstall to JSON.
         * @function toJSON
         * @memberof product.ProductInstall
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        ProductInstall.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return ProductInstall;
    })();

    product.ProductConfig = (function() {

        /**
         * Properties of a ProductConfig.
         * @memberof product
         * @interface IProductConfig
         * @property {string|null} [productCode] ProductConfig productCode
         * @property {string|null} [metadataHash] ProductConfig metadataHash
         * @property {string|null} [timestamp] ProductConfig timestamp
         */

        /**
         * Constructs a new ProductConfig.
         * @memberof product
         * @classdesc Represents a ProductConfig.
         * @implements IProductConfig
         * @constructor
         * @param {product.IProductConfig=} [properties] Properties to set
         */
        function ProductConfig(properties) {
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * ProductConfig productCode.
         * @member {string} productCode
         * @memberof product.ProductConfig
         * @instance
         */
        ProductConfig.prototype.productCode = "";

        /**
         * ProductConfig metadataHash.
         * @member {string} metadataHash
         * @memberof product.ProductConfig
         * @instance
         */
        ProductConfig.prototype.metadataHash = "";

        /**
         * ProductConfig timestamp.
         * @member {string} timestamp
         * @memberof product.ProductConfig
         * @instance
         */
        ProductConfig.prototype.timestamp = "";

        /**
         * Creates a new ProductConfig instance using the specified properties.
         * @function create
         * @memberof product.ProductConfig
         * @static
         * @param {product.IProductConfig=} [properties] Properties to set
         * @returns {product.ProductConfig} ProductConfig instance
         */
        ProductConfig.create = function create(properties) {
            return new ProductConfig(properties);
        };

        /**
         * Encodes the specified ProductConfig message. Does not implicitly {@link product.ProductConfig.verify|verify} messages.
         * @function encode
         * @memberof product.ProductConfig
         * @static
         * @param {product.IProductConfig} message ProductConfig message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        ProductConfig.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.productCode != null && Object.hasOwnProperty.call(message, "productCode"))
                writer.uint32(/* id 1, wireType 2 =*/10).string(message.productCode);
            if (message.metadataHash != null && Object.hasOwnProperty.call(message, "metadataHash"))
                writer.uint32(/* id 2, wireType 2 =*/18).string(message.metadataHash);
            if (message.timestamp != null && Object.hasOwnProperty.call(message, "timestamp"))
                writer.uint32(/* id 3, wireType 2 =*/26).string(message.timestamp);
            return writer;
        };

        /**
         * Encodes the specified ProductConfig message, length delimited. Does not implicitly {@link product.ProductConfig.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.ProductConfig
         * @static
         * @param {product.IProductConfig} message ProductConfig message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        ProductConfig.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes a ProductConfig message from the specified reader or buffer.
         * @function decode
         * @memberof product.ProductConfig
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.ProductConfig} ProductConfig
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        ProductConfig.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.ProductConfig();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    message.productCode = reader.string();
                    break;
                case 2:
                    message.metadataHash = reader.string();
                    break;
                case 3:
                    message.timestamp = reader.string();
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes a ProductConfig message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.ProductConfig
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.ProductConfig} ProductConfig
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        ProductConfig.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies a ProductConfig message.
         * @function verify
         * @memberof product.ProductConfig
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        ProductConfig.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.productCode != null && message.hasOwnProperty("productCode"))
                if (!$util.isString(message.productCode))
                    return "productCode: string expected";
            if (message.metadataHash != null && message.hasOwnProperty("metadataHash"))
                if (!$util.isString(message.metadataHash))
                    return "metadataHash: string expected";
            if (message.timestamp != null && message.hasOwnProperty("timestamp"))
                if (!$util.isString(message.timestamp))
                    return "timestamp: string expected";
            return null;
        };

        /**
         * Creates a ProductConfig message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.ProductConfig
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.ProductConfig} ProductConfig
         */
        ProductConfig.fromObject = function fromObject(object) {
            if (object instanceof $root.product.ProductConfig)
                return object;
            var message = new $root.product.ProductConfig();
            if (object.productCode != null)
                message.productCode = String(object.productCode);
            if (object.metadataHash != null)
                message.metadataHash = String(object.metadataHash);
            if (object.timestamp != null)
                message.timestamp = String(object.timestamp);
            return message;
        };

        /**
         * Creates a plain object from a ProductConfig message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.ProductConfig
         * @static
         * @param {product.ProductConfig} message ProductConfig
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        ProductConfig.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.defaults) {
                object.productCode = "";
                object.metadataHash = "";
                object.timestamp = "";
            }
            if (message.productCode != null && message.hasOwnProperty("productCode"))
                object.productCode = message.productCode;
            if (message.metadataHash != null && message.hasOwnProperty("metadataHash"))
                object.metadataHash = message.metadataHash;
            if (message.timestamp != null && message.hasOwnProperty("timestamp"))
                object.timestamp = message.timestamp;
            return object;
        };

        /**
         * Converts this ProductConfig to JSON.
         * @function toJSON
         * @memberof product.ProductConfig
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        ProductConfig.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return ProductConfig;
    })();

    product.ActiveProcess = (function() {

        /**
         * Properties of an ActiveProcess.
         * @memberof product
         * @interface IActiveProcess
         * @property {string|null} [processName] ActiveProcess processName
         * @property {number|null} [pid] ActiveProcess pid
         * @property {Array.<string>|null} [uri] ActiveProcess uri
         */

        /**
         * Constructs a new ActiveProcess.
         * @memberof product
         * @classdesc Represents an ActiveProcess.
         * @implements IActiveProcess
         * @constructor
         * @param {product.IActiveProcess=} [properties] Properties to set
         */
        function ActiveProcess(properties) {
            this.uri = [];
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * ActiveProcess processName.
         * @member {string} processName
         * @memberof product.ActiveProcess
         * @instance
         */
        ActiveProcess.prototype.processName = "";

        /**
         * ActiveProcess pid.
         * @member {number} pid
         * @memberof product.ActiveProcess
         * @instance
         */
        ActiveProcess.prototype.pid = 0;

        /**
         * ActiveProcess uri.
         * @member {Array.<string>} uri
         * @memberof product.ActiveProcess
         * @instance
         */
        ActiveProcess.prototype.uri = $util.emptyArray;

        /**
         * Creates a new ActiveProcess instance using the specified properties.
         * @function create
         * @memberof product.ActiveProcess
         * @static
         * @param {product.IActiveProcess=} [properties] Properties to set
         * @returns {product.ActiveProcess} ActiveProcess instance
         */
        ActiveProcess.create = function create(properties) {
            return new ActiveProcess(properties);
        };

        /**
         * Encodes the specified ActiveProcess message. Does not implicitly {@link product.ActiveProcess.verify|verify} messages.
         * @function encode
         * @memberof product.ActiveProcess
         * @static
         * @param {product.IActiveProcess} message ActiveProcess message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        ActiveProcess.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.processName != null && Object.hasOwnProperty.call(message, "processName"))
                writer.uint32(/* id 1, wireType 2 =*/10).string(message.processName);
            if (message.pid != null && Object.hasOwnProperty.call(message, "pid"))
                writer.uint32(/* id 2, wireType 0 =*/16).int32(message.pid);
            if (message.uri != null && message.uri.length)
                for (var i = 0; i < message.uri.length; ++i)
                    writer.uint32(/* id 3, wireType 2 =*/26).string(message.uri[i]);
            return writer;
        };

        /**
         * Encodes the specified ActiveProcess message, length delimited. Does not implicitly {@link product.ActiveProcess.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.ActiveProcess
         * @static
         * @param {product.IActiveProcess} message ActiveProcess message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        ActiveProcess.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes an ActiveProcess message from the specified reader or buffer.
         * @function decode
         * @memberof product.ActiveProcess
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.ActiveProcess} ActiveProcess
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        ActiveProcess.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.ActiveProcess();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    message.processName = reader.string();
                    break;
                case 2:
                    message.pid = reader.int32();
                    break;
                case 3:
                    if (!(message.uri && message.uri.length))
                        message.uri = [];
                    message.uri.push(reader.string());
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes an ActiveProcess message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.ActiveProcess
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.ActiveProcess} ActiveProcess
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        ActiveProcess.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies an ActiveProcess message.
         * @function verify
         * @memberof product.ActiveProcess
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        ActiveProcess.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.processName != null && message.hasOwnProperty("processName"))
                if (!$util.isString(message.processName))
                    return "processName: string expected";
            if (message.pid != null && message.hasOwnProperty("pid"))
                if (!$util.isInteger(message.pid))
                    return "pid: integer expected";
            if (message.uri != null && message.hasOwnProperty("uri")) {
                if (!Array.isArray(message.uri))
                    return "uri: array expected";
                for (var i = 0; i < message.uri.length; ++i)
                    if (!$util.isString(message.uri[i]))
                        return "uri: string[] expected";
            }
            return null;
        };

        /**
         * Creates an ActiveProcess message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.ActiveProcess
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.ActiveProcess} ActiveProcess
         */
        ActiveProcess.fromObject = function fromObject(object) {
            if (object instanceof $root.product.ActiveProcess)
                return object;
            var message = new $root.product.ActiveProcess();
            if (object.processName != null)
                message.processName = String(object.processName);
            if (object.pid != null)
                message.pid = object.pid | 0;
            if (object.uri) {
                if (!Array.isArray(object.uri))
                    throw TypeError(".product.ActiveProcess.uri: array expected");
                message.uri = [];
                for (var i = 0; i < object.uri.length; ++i)
                    message.uri[i] = String(object.uri[i]);
            }
            return message;
        };

        /**
         * Creates a plain object from an ActiveProcess message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.ActiveProcess
         * @static
         * @param {product.ActiveProcess} message ActiveProcess
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        ActiveProcess.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.arrays || options.defaults)
                object.uri = [];
            if (options.defaults) {
                object.processName = "";
                object.pid = 0;
            }
            if (message.processName != null && message.hasOwnProperty("processName"))
                object.processName = message.processName;
            if (message.pid != null && message.hasOwnProperty("pid"))
                object.pid = message.pid;
            if (message.uri && message.uri.length) {
                object.uri = [];
                for (var j = 0; j < message.uri.length; ++j)
                    object.uri[j] = message.uri[j];
            }
            return object;
        };

        /**
         * Converts this ActiveProcess to JSON.
         * @function toJSON
         * @memberof product.ActiveProcess
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        ActiveProcess.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return ActiveProcess;
    })();

    product.DownloadSettings = (function() {

        /**
         * Properties of a DownloadSettings.
         * @memberof product
         * @interface IDownloadSettings
         * @property {number|null} [downloadLimit] DownloadSettings downloadLimit
         * @property {number|null} [backfillLimit] DownloadSettings backfillLimit
         */

        /**
         * Constructs a new DownloadSettings.
         * @memberof product
         * @classdesc Represents a DownloadSettings.
         * @implements IDownloadSettings
         * @constructor
         * @param {product.IDownloadSettings=} [properties] Properties to set
         */
        function DownloadSettings(properties) {
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * DownloadSettings downloadLimit.
         * @member {number} downloadLimit
         * @memberof product.DownloadSettings
         * @instance
         */
        DownloadSettings.prototype.downloadLimit = 0;

        /**
         * DownloadSettings backfillLimit.
         * @member {number} backfillLimit
         * @memberof product.DownloadSettings
         * @instance
         */
        DownloadSettings.prototype.backfillLimit = 0;

        /**
         * Creates a new DownloadSettings instance using the specified properties.
         * @function create
         * @memberof product.DownloadSettings
         * @static
         * @param {product.IDownloadSettings=} [properties] Properties to set
         * @returns {product.DownloadSettings} DownloadSettings instance
         */
        DownloadSettings.create = function create(properties) {
            return new DownloadSettings(properties);
        };

        /**
         * Encodes the specified DownloadSettings message. Does not implicitly {@link product.DownloadSettings.verify|verify} messages.
         * @function encode
         * @memberof product.DownloadSettings
         * @static
         * @param {product.IDownloadSettings} message DownloadSettings message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        DownloadSettings.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.downloadLimit != null && Object.hasOwnProperty.call(message, "downloadLimit"))
                writer.uint32(/* id 1, wireType 0 =*/8).int32(message.downloadLimit);
            if (message.backfillLimit != null && Object.hasOwnProperty.call(message, "backfillLimit"))
                writer.uint32(/* id 2, wireType 0 =*/16).int32(message.backfillLimit);
            return writer;
        };

        /**
         * Encodes the specified DownloadSettings message, length delimited. Does not implicitly {@link product.DownloadSettings.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.DownloadSettings
         * @static
         * @param {product.IDownloadSettings} message DownloadSettings message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        DownloadSettings.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes a DownloadSettings message from the specified reader or buffer.
         * @function decode
         * @memberof product.DownloadSettings
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.DownloadSettings} DownloadSettings
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        DownloadSettings.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.DownloadSettings();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    message.downloadLimit = reader.int32();
                    break;
                case 2:
                    message.backfillLimit = reader.int32();
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes a DownloadSettings message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.DownloadSettings
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.DownloadSettings} DownloadSettings
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        DownloadSettings.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies a DownloadSettings message.
         * @function verify
         * @memberof product.DownloadSettings
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        DownloadSettings.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.downloadLimit != null && message.hasOwnProperty("downloadLimit"))
                if (!$util.isInteger(message.downloadLimit))
                    return "downloadLimit: integer expected";
            if (message.backfillLimit != null && message.hasOwnProperty("backfillLimit"))
                if (!$util.isInteger(message.backfillLimit))
                    return "backfillLimit: integer expected";
            return null;
        };

        /**
         * Creates a DownloadSettings message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.DownloadSettings
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.DownloadSettings} DownloadSettings
         */
        DownloadSettings.fromObject = function fromObject(object) {
            if (object instanceof $root.product.DownloadSettings)
                return object;
            var message = new $root.product.DownloadSettings();
            if (object.downloadLimit != null)
                message.downloadLimit = object.downloadLimit | 0;
            if (object.backfillLimit != null)
                message.backfillLimit = object.backfillLimit | 0;
            return message;
        };

        /**
         * Creates a plain object from a DownloadSettings message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.DownloadSettings
         * @static
         * @param {product.DownloadSettings} message DownloadSettings
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        DownloadSettings.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.defaults) {
                object.downloadLimit = 0;
                object.backfillLimit = 0;
            }
            if (message.downloadLimit != null && message.hasOwnProperty("downloadLimit"))
                object.downloadLimit = message.downloadLimit;
            if (message.backfillLimit != null && message.hasOwnProperty("backfillLimit"))
                object.backfillLimit = message.backfillLimit;
            return object;
        };

        /**
         * Converts this DownloadSettings to JSON.
         * @function toJSON
         * @memberof product.DownloadSettings
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        DownloadSettings.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return DownloadSettings;
    })();

    product.ProductDb = (function() {

        /**
         * Properties of a ProductDb.
         * @memberof product
         * @interface IProductDb
         * @property {Array.<product.IProductInstall>|null} [productInstalls] ProductDb productInstalls
         * @property {Array.<product.IInstallHandshake>|null} [activeInstalls] ProductDb activeInstalls
         * @property {Array.<product.IActiveProcess>|null} [activeProcesses] ProductDb activeProcesses
         * @property {Array.<product.IProductConfig>|null} [productConfigs] ProductDb productConfigs
         * @property {product.IDownloadSettings|null} [downloadSettings] ProductDb downloadSettings
         */

        /**
         * Constructs a new ProductDb.
         * @memberof product
         * @classdesc Represents a ProductDb.
         * @implements IProductDb
         * @constructor
         * @param {product.IProductDb=} [properties] Properties to set
         */
        function ProductDb(properties) {
            this.productInstalls = [];
            this.activeInstalls = [];
            this.activeProcesses = [];
            this.productConfigs = [];
            if (properties)
                for (var keys = Object.keys(properties), i = 0; i < keys.length; ++i)
                    if (properties[keys[i]] != null)
                        this[keys[i]] = properties[keys[i]];
        }

        /**
         * ProductDb productInstalls.
         * @member {Array.<product.IProductInstall>} productInstalls
         * @memberof product.ProductDb
         * @instance
         */
        ProductDb.prototype.productInstalls = $util.emptyArray;

        /**
         * ProductDb activeInstalls.
         * @member {Array.<product.IInstallHandshake>} activeInstalls
         * @memberof product.ProductDb
         * @instance
         */
        ProductDb.prototype.activeInstalls = $util.emptyArray;

        /**
         * ProductDb activeProcesses.
         * @member {Array.<product.IActiveProcess>} activeProcesses
         * @memberof product.ProductDb
         * @instance
         */
        ProductDb.prototype.activeProcesses = $util.emptyArray;

        /**
         * ProductDb productConfigs.
         * @member {Array.<product.IProductConfig>} productConfigs
         * @memberof product.ProductDb
         * @instance
         */
        ProductDb.prototype.productConfigs = $util.emptyArray;

        /**
         * ProductDb downloadSettings.
         * @member {product.IDownloadSettings|null|undefined} downloadSettings
         * @memberof product.ProductDb
         * @instance
         */
        ProductDb.prototype.downloadSettings = null;

        /**
         * Creates a new ProductDb instance using the specified properties.
         * @function create
         * @memberof product.ProductDb
         * @static
         * @param {product.IProductDb=} [properties] Properties to set
         * @returns {product.ProductDb} ProductDb instance
         */
        ProductDb.create = function create(properties) {
            return new ProductDb(properties);
        };

        /**
         * Encodes the specified ProductDb message. Does not implicitly {@link product.ProductDb.verify|verify} messages.
         * @function encode
         * @memberof product.ProductDb
         * @static
         * @param {product.IProductDb} message ProductDb message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        ProductDb.encode = function encode(message, writer) {
            if (!writer)
                writer = $Writer.create();
            if (message.productInstalls != null && message.productInstalls.length)
                for (var i = 0; i < message.productInstalls.length; ++i)
                    $root.product.ProductInstall.encode(message.productInstalls[i], writer.uint32(/* id 1, wireType 2 =*/10).fork()).ldelim();
            if (message.activeInstalls != null && message.activeInstalls.length)
                for (var i = 0; i < message.activeInstalls.length; ++i)
                    $root.product.InstallHandshake.encode(message.activeInstalls[i], writer.uint32(/* id 2, wireType 2 =*/18).fork()).ldelim();
            if (message.activeProcesses != null && message.activeProcesses.length)
                for (var i = 0; i < message.activeProcesses.length; ++i)
                    $root.product.ActiveProcess.encode(message.activeProcesses[i], writer.uint32(/* id 3, wireType 2 =*/26).fork()).ldelim();
            if (message.productConfigs != null && message.productConfigs.length)
                for (var i = 0; i < message.productConfigs.length; ++i)
                    $root.product.ProductConfig.encode(message.productConfigs[i], writer.uint32(/* id 4, wireType 2 =*/34).fork()).ldelim();
            if (message.downloadSettings != null && Object.hasOwnProperty.call(message, "downloadSettings"))
                $root.product.DownloadSettings.encode(message.downloadSettings, writer.uint32(/* id 5, wireType 2 =*/42).fork()).ldelim();
            return writer;
        };

        /**
         * Encodes the specified ProductDb message, length delimited. Does not implicitly {@link product.ProductDb.verify|verify} messages.
         * @function encodeDelimited
         * @memberof product.ProductDb
         * @static
         * @param {product.IProductDb} message ProductDb message or plain object to encode
         * @param {$protobuf.Writer} [writer] Writer to encode to
         * @returns {$protobuf.Writer} Writer
         */
        ProductDb.encodeDelimited = function encodeDelimited(message, writer) {
            return this.encode(message, writer).ldelim();
        };

        /**
         * Decodes a ProductDb message from the specified reader or buffer.
         * @function decode
         * @memberof product.ProductDb
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @param {number} [length] Message length if known beforehand
         * @returns {product.ProductDb} ProductDb
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        ProductDb.decode = function decode(reader, length) {
            if (!(reader instanceof $Reader))
                reader = $Reader.create(reader);
            var end = length === undefined ? reader.len : reader.pos + length, message = new $root.product.ProductDb();
            while (reader.pos < end) {
                var tag = reader.uint32();
                switch (tag >>> 3) {
                case 1:
                    if (!(message.productInstalls && message.productInstalls.length))
                        message.productInstalls = [];
                    message.productInstalls.push($root.product.ProductInstall.decode(reader, reader.uint32()));
                    break;
                case 2:
                    if (!(message.activeInstalls && message.activeInstalls.length))
                        message.activeInstalls = [];
                    message.activeInstalls.push($root.product.InstallHandshake.decode(reader, reader.uint32()));
                    break;
                case 3:
                    if (!(message.activeProcesses && message.activeProcesses.length))
                        message.activeProcesses = [];
                    message.activeProcesses.push($root.product.ActiveProcess.decode(reader, reader.uint32()));
                    break;
                case 4:
                    if (!(message.productConfigs && message.productConfigs.length))
                        message.productConfigs = [];
                    message.productConfigs.push($root.product.ProductConfig.decode(reader, reader.uint32()));
                    break;
                case 5:
                    message.downloadSettings = $root.product.DownloadSettings.decode(reader, reader.uint32());
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
                }
            }
            return message;
        };

        /**
         * Decodes a ProductDb message from the specified reader or buffer, length delimited.
         * @function decodeDelimited
         * @memberof product.ProductDb
         * @static
         * @param {$protobuf.Reader|Uint8Array} reader Reader or buffer to decode from
         * @returns {product.ProductDb} ProductDb
         * @throws {Error} If the payload is not a reader or valid buffer
         * @throws {$protobuf.util.ProtocolError} If required fields are missing
         */
        ProductDb.decodeDelimited = function decodeDelimited(reader) {
            if (!(reader instanceof $Reader))
                reader = new $Reader(reader);
            return this.decode(reader, reader.uint32());
        };

        /**
         * Verifies a ProductDb message.
         * @function verify
         * @memberof product.ProductDb
         * @static
         * @param {Object.<string,*>} message Plain object to verify
         * @returns {string|null} `null` if valid, otherwise the reason why it is not
         */
        ProductDb.verify = function verify(message) {
            if (typeof message !== "object" || message === null)
                return "object expected";
            if (message.productInstalls != null && message.hasOwnProperty("productInstalls")) {
                if (!Array.isArray(message.productInstalls))
                    return "productInstalls: array expected";
                for (var i = 0; i < message.productInstalls.length; ++i) {
                    var error = $root.product.ProductInstall.verify(message.productInstalls[i]);
                    if (error)
                        return "productInstalls." + error;
                }
            }
            if (message.activeInstalls != null && message.hasOwnProperty("activeInstalls")) {
                if (!Array.isArray(message.activeInstalls))
                    return "activeInstalls: array expected";
                for (var i = 0; i < message.activeInstalls.length; ++i) {
                    var error = $root.product.InstallHandshake.verify(message.activeInstalls[i]);
                    if (error)
                        return "activeInstalls." + error;
                }
            }
            if (message.activeProcesses != null && message.hasOwnProperty("activeProcesses")) {
                if (!Array.isArray(message.activeProcesses))
                    return "activeProcesses: array expected";
                for (var i = 0; i < message.activeProcesses.length; ++i) {
                    var error = $root.product.ActiveProcess.verify(message.activeProcesses[i]);
                    if (error)
                        return "activeProcesses." + error;
                }
            }
            if (message.productConfigs != null && message.hasOwnProperty("productConfigs")) {
                if (!Array.isArray(message.productConfigs))
                    return "productConfigs: array expected";
                for (var i = 0; i < message.productConfigs.length; ++i) {
                    var error = $root.product.ProductConfig.verify(message.productConfigs[i]);
                    if (error)
                        return "productConfigs." + error;
                }
            }
            if (message.downloadSettings != null && message.hasOwnProperty("downloadSettings")) {
                var error = $root.product.DownloadSettings.verify(message.downloadSettings);
                if (error)
                    return "downloadSettings." + error;
            }
            return null;
        };

        /**
         * Creates a ProductDb message from a plain object. Also converts values to their respective internal types.
         * @function fromObject
         * @memberof product.ProductDb
         * @static
         * @param {Object.<string,*>} object Plain object
         * @returns {product.ProductDb} ProductDb
         */
        ProductDb.fromObject = function fromObject(object) {
            if (object instanceof $root.product.ProductDb)
                return object;
            var message = new $root.product.ProductDb();
            if (object.productInstalls) {
                if (!Array.isArray(object.productInstalls))
                    throw TypeError(".product.ProductDb.productInstalls: array expected");
                message.productInstalls = [];
                for (var i = 0; i < object.productInstalls.length; ++i) {
                    if (typeof object.productInstalls[i] !== "object")
                        throw TypeError(".product.ProductDb.productInstalls: object expected");
                    message.productInstalls[i] = $root.product.ProductInstall.fromObject(object.productInstalls[i]);
                }
            }
            if (object.activeInstalls) {
                if (!Array.isArray(object.activeInstalls))
                    throw TypeError(".product.ProductDb.activeInstalls: array expected");
                message.activeInstalls = [];
                for (var i = 0; i < object.activeInstalls.length; ++i) {
                    if (typeof object.activeInstalls[i] !== "object")
                        throw TypeError(".product.ProductDb.activeInstalls: object expected");
                    message.activeInstalls[i] = $root.product.InstallHandshake.fromObject(object.activeInstalls[i]);
                }
            }
            if (object.activeProcesses) {
                if (!Array.isArray(object.activeProcesses))
                    throw TypeError(".product.ProductDb.activeProcesses: array expected");
                message.activeProcesses = [];
                for (var i = 0; i < object.activeProcesses.length; ++i) {
                    if (typeof object.activeProcesses[i] !== "object")
                        throw TypeError(".product.ProductDb.activeProcesses: object expected");
                    message.activeProcesses[i] = $root.product.ActiveProcess.fromObject(object.activeProcesses[i]);
                }
            }
            if (object.productConfigs) {
                if (!Array.isArray(object.productConfigs))
                    throw TypeError(".product.ProductDb.productConfigs: array expected");
                message.productConfigs = [];
                for (var i = 0; i < object.productConfigs.length; ++i) {
                    if (typeof object.productConfigs[i] !== "object")
                        throw TypeError(".product.ProductDb.productConfigs: object expected");
                    message.productConfigs[i] = $root.product.ProductConfig.fromObject(object.productConfigs[i]);
                }
            }
            if (object.downloadSettings != null) {
                if (typeof object.downloadSettings !== "object")
                    throw TypeError(".product.ProductDb.downloadSettings: object expected");
                message.downloadSettings = $root.product.DownloadSettings.fromObject(object.downloadSettings);
            }
            return message;
        };

        /**
         * Creates a plain object from a ProductDb message. Also converts values to other types if specified.
         * @function toObject
         * @memberof product.ProductDb
         * @static
         * @param {product.ProductDb} message ProductDb
         * @param {$protobuf.IConversionOptions} [options] Conversion options
         * @returns {Object.<string,*>} Plain object
         */
        ProductDb.toObject = function toObject(message, options) {
            if (!options)
                options = {};
            var object = {};
            if (options.arrays || options.defaults) {
                object.productInstalls = [];
                object.activeInstalls = [];
                object.activeProcesses = [];
                object.productConfigs = [];
            }
            if (options.defaults)
                object.downloadSettings = null;
            if (message.productInstalls && message.productInstalls.length) {
                object.productInstalls = [];
                for (var j = 0; j < message.productInstalls.length; ++j)
                    object.productInstalls[j] = $root.product.ProductInstall.toObject(message.productInstalls[j], options);
            }
            if (message.activeInstalls && message.activeInstalls.length) {
                object.activeInstalls = [];
                for (var j = 0; j < message.activeInstalls.length; ++j)
                    object.activeInstalls[j] = $root.product.InstallHandshake.toObject(message.activeInstalls[j], options);
            }
            if (message.activeProcesses && message.activeProcesses.length) {
                object.activeProcesses = [];
                for (var j = 0; j < message.activeProcesses.length; ++j)
                    object.activeProcesses[j] = $root.product.ActiveProcess.toObject(message.activeProcesses[j], options);
            }
            if (message.productConfigs && message.productConfigs.length) {
                object.productConfigs = [];
                for (var j = 0; j < message.productConfigs.length; ++j)
                    object.productConfigs[j] = $root.product.ProductConfig.toObject(message.productConfigs[j], options);
            }
            if (message.downloadSettings != null && message.hasOwnProperty("downloadSettings"))
                object.downloadSettings = $root.product.DownloadSettings.toObject(message.downloadSettings, options);
            return object;
        };

        /**
         * Converts this ProductDb to JSON.
         * @function toJSON
         * @memberof product.ProductDb
         * @instance
         * @returns {Object.<string,*>} JSON object
         */
        ProductDb.prototype.toJSON = function toJSON() {
            return this.constructor.toObject(this, $protobuf.util.toJSONOptions);
        };

        return ProductDb;
    })();

    /**
     * LanguageOption enum.
     * @name product.LanguageOption
     * @enum {string}
     * @property {number} LANGOPTION_NONE=0 LANGOPTION_NONE value
     * @property {number} LANGOPTION_TEXT=1 LANGOPTION_TEXT value
     * @property {number} LANGOPTION_SPEECH=2 LANGOPTION_SPEECH value
     * @property {number} LANGOPTION_TEXT_AND_SPEECH=3 LANGOPTION_TEXT_AND_SPEECH value
     */
    product.LanguageOption = (function() {
        var valuesById = {}, values = Object.create(valuesById);
        values[valuesById[0] = "LANGOPTION_NONE"] = 0;
        values[valuesById[1] = "LANGOPTION_TEXT"] = 1;
        values[valuesById[2] = "LANGOPTION_SPEECH"] = 2;
        values[valuesById[3] = "LANGOPTION_TEXT_AND_SPEECH"] = 3;
        return values;
    })();

    /**
     * LanguageSettingType enum.
     * @name product.LanguageSettingType
     * @enum {string}
     * @property {number} LANGSETTING_NONE=0 LANGSETTING_NONE value
     * @property {number} LANGSETTING_SINGLE=1 LANGSETTING_SINGLE value
     * @property {number} LANGSETTING_SIMPLE=2 LANGSETTING_SIMPLE value
     * @property {number} LANGSETTING_ADVANCED=3 LANGSETTING_ADVANCED value
     */
    product.LanguageSettingType = (function() {
        var valuesById = {}, values = Object.create(valuesById);
        values[valuesById[0] = "LANGSETTING_NONE"] = 0;
        values[valuesById[1] = "LANGSETTING_SINGLE"] = 1;
        values[valuesById[2] = "LANGSETTING_SIMPLE"] = 2;
        values[valuesById[3] = "LANGSETTING_ADVANCED"] = 3;
        return values;
    })();

    /**
     * ShortcutOption enum.
     * @name product.ShortcutOption
     * @enum {string}
     * @property {number} SHORTCUT_NONE=0 SHORTCUT_NONE value
     * @property {number} SHORTCUT_USER=1 SHORTCUT_USER value
     * @property {number} SHORTCUT_ALL_USERS=2 SHORTCUT_ALL_USERS value
     */
    product.ShortcutOption = (function() {
        var valuesById = {}, values = Object.create(valuesById);
        values[valuesById[0] = "SHORTCUT_NONE"] = 0;
        values[valuesById[1] = "SHORTCUT_USER"] = 1;
        values[valuesById[2] = "SHORTCUT_ALL_USERS"] = 2;
        return values;
    })();

    /**
     * Operation enum.
     * @name product.Operation
     * @enum {string}
     * @property {number} OP_UPDATE=0 OP_UPDATE value
     * @property {number} OP_BACKFILL=1 OP_BACKFILL value
     * @property {number} OP_REPAIR=2 OP_REPAIR value
     * @property {number} OP_NONE=-1 OP_NONE value
     */
    product.Operation = (function() {
        var valuesById = {}, values = Object.create(valuesById);
        values[valuesById[0] = "OP_UPDATE"] = 0;
        values[valuesById[1] = "OP_BACKFILL"] = 1;
        values[valuesById[2] = "OP_REPAIR"] = 2;
        values[valuesById[-1] = "OP_NONE"] = -1;
        return values;
    })();

    return product;
})();

module.exports = $root;
