## [0.3.7-rc.0](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.3.6...v0.3.7-rc.0) (2026-06-25)


### Bug Fixes

* canonicalize template EOL to LF and harden golden generation ([9ae8533](https://github.com/warcraft-iii/warcraft-vscode/commit/9ae853393b3771cd3c9634a813ad5a3e3d7a5609))
* **cli:** non-zero exit on invalid compile arguments ([58abebc](https://github.com/warcraft-iii/warcraft-vscode/commit/58abebcf9cd921af546e5064700eca766c470458))
* **confuse:** patch Prometheus math.log10 for Lua 5.1/5.4 compat ([6e066d0](https://github.com/warcraft-iii/warcraft-vscode/commit/6e066d00902efe9b467558bbba334e71d9dfe411))
* **core:** include exit status in ObjEditing failure message ([8602902](https://github.com/warcraft-iii/warcraft-vscode/commit/86029020e1edc200c731bb1c6d24af951e30d390))
* **core:** keep space after numeric literals before dot/word tokens ([bba2784](https://github.com/warcraft-iii/warcraft-vscode/commit/bba27847857061ca7d4f33b64ff90286ea8d584f))
* **core:** pre-delete extraction outputs and cover scripts fallback ([c704f24](https://github.com/warcraft-iii/warcraft-vscode/commit/c704f24c9dcbb93daef0d31eb9eaefcbc69f4803))
* **core:** propagate walk errors in source collection ([3e71647](https://github.com/warcraft-iii/warcraft-vscode/commit/3e71647192ca21ad6101ab5c409814394065a2b2))
* **core:** restrict compiletime detection to bare paren calls ([1f861ec](https://github.com/warcraft-iii/warcraft-vscode/commit/1f861ec880459a0359f54b624fa35f6aa2851d21))
* **core:** scan requires followed by member access or chained calls ([31c112a](https://github.com/warcraft-iii/warcraft-vscode/commit/31c112a100ebb938bb6ef172124fe55e0ddf6fd3))
* **core:** scripts fallback when extracting war3map.lua from file maps ([ef8755f](https://github.com/warcraft-iii/warcraft-vscode/commit/ef8755f156f844be83097b1a97a63707d8bb5148))
* **core:** top-to-bottom compiletime eval, shared engine per build, AST-precise args ([01e2848](https://github.com/warcraft-iii/warcraft-vscode/commit/01e28489618b889022ebe7115cf97f4cd85b515f))
* **core:** use cross-platform paths in unit tests (macOS compat) ([4524dea](https://github.com/warcraft-iii/warcraft-vscode/commit/4524dea6a17e1724bc7506f64f1a3bc044b91e3b))
* **deps:** update stormlib rev to c954b79 (cmake 4.x compat fix) ([5f98d8f](https://github.com/warcraft-iii/warcraft-vscode/commit/5f98d8fece291095598af927aff1b0db33503d08))
* enable lua54 syntax parsing in full_moon ([84450d7](https://github.com/warcraft-iii/warcraft-vscode/commit/84450d7ca20be73c09a44f278bb7801a460fea70))
* **ext:** update bin/cli.js launcher, remove obsolete TS template sync test ([c835ca8](https://github.com/warcraft-iii/warcraft-vscode/commit/c835ca8a5ae89feb0d42f8817959bd424483fc60))


### Features

* **cli:** add compile-only subcommand for golden baseline ([0422a99](https://github.com/warcraft-iii/warcraft-vscode/commit/0422a993b564a3e864543ee94f23eb89f38481b8))
* **cli:** objediting, pack and build subcommands ([6855597](https://github.com/warcraft-iii/warcraft-vscode/commit/685559766bebcad8304191a048921902c35ca291))
* **cli:** wc3 compile subcommand with NDJSON events ([95f60a8](https://github.com/warcraft-iii/warcraft-vscode/commit/95f60a89ca2b5f622bc9c97dceab268f8ee73430))
* **confuse:** prometheus runner spike on mlua/lua51 ([e1566ca](https://github.com/warcraft-iii/warcraft-vscode/commit/e1566caf293173baff854499a67ddf4f28d9501a))
* **core:** comment macro processing (debug/release/classic/reforge) ([6124a31](https://github.com/warcraft-iii/warcraft-vscode/commit/6124a312cd653643d13349af7d1c182b7589d31d))
* **core:** compiletime evaluation via mlua with span substitution ([c43d4ac](https://github.com/warcraft-iii/warcraft-vscode/commit/c43d4ac3e7ac09ae1667ba53d3c438cd88061e4b))
* **core:** debug compile pipeline ([3ebc35e](https://github.com/warcraft-iii/warcraft-vscode/commit/3ebc35eb9e5f756ba19d8e7192180056f1c36d38))
* **core:** debug/release template rendering with classic gating ([9299851](https://github.com/warcraft-iii/warcraft-vscode/commit/929985168654d4756e2e10956322da355d739d29))
* **core:** embed ObjEditing Lua VM, eliminate ObjEditing.exe dependency ([d7723ad](https://github.com/warcraft-iii/warcraft-vscode/commit/d7723adeb36151a0aed754320a985f94cc5c1913))
* **core:** extract file/line from minify parse errors and ObjEditing Lua tracebacks ([c28ce23](https://github.com/warcraft-iii/warcraft-vscode/commit/c28ce23a021607089ad7f015ff5235d7edd4fada))
* **core:** lua literal helpers (comment level, keys, value serialization) ([4dbaa82](https://github.com/warcraft-iii/warcraft-vscode/commit/4dbaa8298193e6bd0419a7c1c8739e28455d02c7))
* **core:** map packing via stormlib (generate and copy-append paths) ([adf0d46](https://github.com/warcraft-iii/warcraft-vscode/commit/adf0d4614e96c06a0d8c7ea6967797ce76d20146))
* **core:** mpq module backed by stormlib crate (git dep) ([58bd9de](https://github.com/warcraft-iii/warcraft-vscode/commit/58bd9debc2dec795431383059a54ad92da12209b))
* **core:** objediting orchestration (def management, source prep, exe wrapper) ([657201e](https://github.com/warcraft-iii/warcraft-vscode/commit/657201edafe86c32b4cd88d155578f7706d5b143))
* **core:** pack file collection and windows-style relative names ([bd63e4f](https://github.com/warcraft-iii/warcraft-vscode/commit/bd63e4fdced6c6ca44346069165632f66e632ba7))
* **core:** packlist generation replicating TS order and dedup ([6b9daf1](https://github.com/warcraft-iii/warcraft-vscode/commit/6b9daf19d053541ef7737ceede1ca3d3e61c06b5))
* **core:** project config parsing and build context ([a7fb053](https://github.com/warcraft-iii/warcraft-vscode/commit/a7fb05338e66138bfc12fe81302452619dac408f))
* **core:** release compile pipeline with require graph ([3f4b6a6](https://github.com/warcraft-iii/warcraft-vscode/commit/3f4b6a67221771098ab32471e13e5ee9157611a5))
* **core:** require/dofile/loadfile scanning and resolution ([4d5ee3e](https://github.com/warcraft-iii/warcraft-vscode/commit/4d5ee3ea84b790e09a6e8a1305d0c2e026c01e41))
* **core:** source file collection and naming rules ([f1e12ca](https://github.com/warcraft-iii/warcraft-vscode/commit/f1e12cafa6d0c25f167982daf097bc6498f6eb2a))
* **core:** token-level lua minifier (no renaming) ([eaf7655](https://github.com/warcraft-iii/warcraft-vscode/commit/eaf765551cc3aa66452b902fa3f1e4993fe9a361))
* **core:** war3map.j cheat injection and mopaq subprocess wrapper ([f0e561e](https://github.com/warcraft-iii/warcraft-vscode/commit/f0e561e3138b4f030b22c3d7aa452b1cac8350f6))
* **ext:** NDJSON bridge for spawning wc3.exe subprocess ([f1b0f11](https://github.com/warcraft-iii/warcraft-vscode/commit/f1b0f11e8783f8aa62ec16246350c3dc41075a4e))
* structured error reporting with file/line location ([e45d289](https://github.com/warcraft-iii/warcraft-vscode/commit/e45d28964e5b75cd6857967b866587d7cbcd2394))


### Performance Improvements

* **core:** linear token collection in minify, clearer spacing state ([fdd2e42](https://github.com/warcraft-iii/warcraft-vscode/commit/fdd2e420ce35a4b6b4b6839894dd1d3252f2b32a))
## [0.3.6](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.3.5...v0.3.6) (2026-04-18)



## [0.3.5](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.3.4...v0.3.5) (2026-01-19)



## [0.3.4](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.3.3...v0.3.4) (2025-12-30)


### Reverts

* Revert "fix: run prepare failed" ([4f5a8b9](https://github.com/warcraft-iii/warcraft-vscode/commit/4f5a8b9246f0fb3b2eb6a1fa04767f2e501a7381))



## [0.3.3](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.3.2...v0.3.3) (2025-12-30)


### Bug Fixes

* @types/vscode version ([a1465cb](https://github.com/warcraft-iii/warcraft-vscode/commit/a1465cba54924e9494083965433e1b4af8d0964a))
* run prepare failed ([dc9ab67](https://github.com/warcraft-iii/warcraft-vscode/commit/dc9ab67e2d0fc6c456f7469b8995c851bc563a49))



## [0.3.2](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.3.1...v0.3.2) (2025-11-10)


### Bug Fixes

* CI build ([86d487e](https://github.com/warcraft-iii/warcraft-vscode/commit/86d487e8d956c47a9d59cedc2008534e3a40a7e7))



## [0.3.1](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.3.0...v0.3.1) (2025-11-06)


### Features

* Object editing folder supports specifying Warcraft III versions. ([0a10714](https://github.com/warcraft-iii/warcraft-vscode/commit/0a1071433b1138a9de0e63d685cd2613dc8c7100))



# [0.3.0](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.2.9...v0.3.0) (2025-02-18)


### Bug Fixes

* **cli:** Invalid lua confusion parameter ([8a4a663](https://github.com/warcraft-iii/warcraft-vscode/commit/8a4a6638a4a223b2e14440ffcf7edf9d6bc4b39d))



## [0.2.9](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.2.8...v0.2.9) (2024-07-10)


### Bug Fixes

* wasmoon load failed ([769dea3](https://github.com/warcraft-iii/warcraft-vscode/commit/769dea3197c6c7a4c78c8713d1b50748dd624a03))



## [0.2.8](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.2.7...v0.2.8) (2024-07-10)


### Bug Fixes

* Parameters are not correctly confused ([11b91c9](https://github.com/warcraft-iii/warcraft-vscode/commit/11b91c94f55db1eee7b64f36e955f0b54f7f49ee))


### Features

* Adding the lua code obfuscation module ([494b40c](https://github.com/warcraft-iii/warcraft-vscode/commit/494b40cf5c04107a3f8a4eebe85746538515a9c0))



## [0.2.7](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.2.6...v0.2.7) (2024-07-09)


### Bug Fixes

* Parameters are not correctly confused ([9fc1454](https://github.com/warcraft-iii/warcraft-vscode/commit/9fc1454f412fe5c930dd3dd27a1a947a7172b561))



## [0.2.6](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.2.5...v0.2.6) (2024-05-24)



## [0.2.5](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.2.4...v0.2.5) (2024-05-23)


### Bug Fixes

* load wasmoon failed ([1a09272](https://github.com/warcraft-iii/warcraft-vscode/commit/1a092727e87f5462edc5b4b64ba00e3dd5bfc8ca))



## [0.2.4](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.2.3...v0.2.4) (2024-05-23)


### Bug Fixes

* prepare.js copy file failed ([4810966](https://github.com/warcraft-iii/warcraft-vscode/commit/48109666e2e5b618ea88fbf1a4779893c577f9d4))
* prepare.js copy file failed ([25f0408](https://github.com/warcraft-iii/warcraft-vscode/commit/25f04083615618a1fb4bf2f364ddb12be7652050))



## [0.2.3](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.2.2...v0.2.3) (2024-05-23)


### Bug Fixes

* Some macros don't work properly when compiling scripts ([12038a3](https://github.com/warcraft-iii/warcraft-vscode/commit/12038a3e0e02941ac6804244e75f0461a10955e4))



## [0.2.2](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.2.1...v0.2.2) (2024-05-22)


### Features

* Running compiletime with wasmoon ([74f0ea1](https://github.com/warcraft-iii/warcraft-vscode/commit/74f0ea1e31e3e71fcb45340b6465e2af72554f6e))



## [0.2.1](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.2.0...v0.2.1) (2024-05-22)


### Bug Fixes

* Incorrect ObjectEditing checkDefine ([c38a16d](https://github.com/warcraft-iii/warcraft-vscode/commit/c38a16d7d53a4740da2f8b99f58160f20da81052))



# [0.2.0](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.16...v0.2.0) (2024-05-22)


### Bug Fixes

* Incorrect Warcraft version when compiling scripts using the command line ([d780849](https://github.com/warcraft-iii/warcraft-vscode/commit/d78084950798b8577b1f5d312a41160e4f7110fd))
* Some macros don't work properly when compiling scripts ([cb21780](https://github.com/warcraft-iii/warcraft-vscode/commit/cb21780ac31721d61c3197585a9c0a1a230ca7ac))


### Features

* Implement the compiletime API to run during the packaging process and get results ([dfb9b2a](https://github.com/warcraft-iii/warcraft-vscode/commit/dfb9b2ae0051cd3d042ec6128db1a2e4e67b034c))
* Packaging maps via the nodejs command line ([3f107c6](https://github.com/warcraft-iii/warcraft-vscode/commit/3f107c68662bab4a11dc215d0b1628c880f70c5f))



## [0.1.16](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.15...v0.1.16) (2024-05-17)


### Features

* **packer:** `imports` support for specific Warcraft versions (ex. imports.reforge) ([51af8f2](https://github.com/warcraft-iii/warcraft-vscode/commit/51af8f25b604445476790d6db4435d457025b00b))



## [0.1.15](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.14...v0.1.15) (2024-03-29)



## [0.1.14](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.13...v0.1.14) (2024-03-25)


### Features

* Create Project support use classic template ([ddb1b6e](https://github.com/warcraft-iii/warcraft-vscode/commit/ddb1b6e2f82b9f5ecef93cafefa3087b4c28ffd4))



## [0.1.13](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.12...v0.1.13) (2023-07-12)



## [0.1.12](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.11...v0.1.12) (2023-07-12)


### Bug Fixes

* **deps:** build failed with protobufjs 6.11.3 ([2388287](https://github.com/warcraft-iii/warcraft-vscode/commit/2388287ceedb4d28676648808102665a00008c11))
* simple-git ([d8c3a41](https://github.com/warcraft-iii/warcraft-vscode/commit/d8c3a4182a9cf6b53d0d89aae1ceb7aba8753093))



## [0.1.11](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.10...v0.1.11) (2021-08-25)


### Bug Fixes

* When compile lua files failed then throw the details ([f3c1377](https://github.com/warcraft-iii/warcraft-vscode/commit/f3c137717736194f42b87b47cf7c1b39108aa368))



## [0.1.10](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.9...v0.1.10) (2021-08-19)


### Bug Fixes

* **classic:** Re-executing "Run Map" did not close the last launched game client correctly ([956aa3d](https://github.com/warcraft-iii/warcraft-vscode/commit/956aa3d5783f024f1a4af2fcbababbe53db9cef1))



## [0.1.9](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.8...v0.1.9) (2021-06-28)



## [0.1.8](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.7...v0.1.8) (2021-05-18)


### Bug Fixes

* **classic:** Check the game running status failure ([5edaced](https://github.com/warcraft-iii/warcraft-vscode/commit/5edaced51146911a63760067fda416e7339fc99f))
* Incorrect object editing path ([2f7171d](https://github.com/warcraft-iii/warcraft-vscode/commit/2f7171dd24c8a24fa6ad5030cc0e1bbb520cb0c0))



## [0.1.7](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.6...v0.1.7) (2021-05-17)


### Bug Fixes

* Objediting`s def files are not deployed ([4d51528](https://github.com/warcraft-iii/warcraft-vscode/commit/4d51528a2eed0791e1c0072b0e4465531a567ac9))



## [0.1.6](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.5...v0.1.6) (2021-05-17)


### Bug Fixes

* **classic:** No Maps/Test directory created cause failed to start map ([3a695f7](https://github.com/warcraft-iii/warcraft-vscode/commit/3a695f70727ef3291999e96ee5b1b8d67817fdaf))



## [0.1.5](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.4...v0.1.5) (2021-05-17)


### Bug Fixes

* Duplicate lua package path configuration content when switching map files ([9ef702c](https://github.com/warcraft-iii/warcraft-vscode/commit/9ef702c824b6cf69f2f91c23b6822ff3d493e769))



## [0.1.4](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.3...v0.1.4) (2021-05-13)


### Features

* **classic:** Specify the path to the war3map.j file or use it in the map file. ([b01dc79](https://github.com/warcraft-iii/warcraft-vscode/commit/b01dc792d29dfec8c7536e39fbf9885856991d22))



## [0.1.3](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.2...v0.1.3) (2021-05-13)


### Bug Fixes

* **Objediting:** Merge built-in object config failure ([5b9fda1](https://github.com/warcraft-iii/warcraft-vscode/commit/5b9fda1d96f9e680a500c617830b5ecbca000149))



## [0.1.2](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.1...v0.1.2) (2021-05-11)


### Bug Fixes

* **classic:** Unable to pack map when opening WE ([a2c92d4](https://github.com/warcraft-iii/warcraft-vscode/commit/a2c92d4e238fc905031daccbf336248f1caa3728))



## [0.1.1](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.1.0...v0.1.1) (2021-05-11)


### Features

* Open map files with YDWE ([bbc6546](https://github.com/warcraft-iii/warcraft-vscode/commit/bbc65469a50c06a2f2002e625c9485fdf5aa407a))



# [0.1.0](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.34...v0.1.0) (2021-05-11)


### Bug Fixes

* Loading lua.package.path from warcraft.json is incorrect ([dfb90c3](https://github.com/warcraft-iii/warcraft-vscode/commit/dfb90c30c33e309c8ad30d1c1785eca8c148bc40))


### Features

* Add chose map file command ([baf4202](https://github.com/warcraft-iii/warcraft-vscode/commit/baf42024b0006164b85c407c243fa12d2333374d))
* Pack map file as the YDWE format ([c2a9b3d](https://github.com/warcraft-iii/warcraft-vscode/commit/c2a9b3d8e5646abbe72da2c651655f21de0a72b4))
* Support Warcraft III Classic Version (WIP) ([f9fc629](https://github.com/warcraft-iii/warcraft-vscode/commit/f9fc629b8321f16245edd5e8788ec9e7e71d3f75))



## [0.0.34](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.33...v0.0.34) (2020-07-17)


### Bug Fixes

* Invalid ".product.db" file path ([82ad861](https://github.com/warcraft-iii/warcraft-vscode/commit/82ad861))



## [0.0.33](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.32...v0.0.33) (2020-07-01)


### Bug Fixes

* **ObjEditing:** Miss object fields when load existing war3map.* file ([3e70411](https://github.com/warcraft-iii/warcraft-vscode/commit/3e70411))



## [0.0.32](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.31...v0.0.32) (2020-06-15)


### Bug Fixes

* Invalid Game/WE launch parameter config ([429d506](https://github.com/warcraft-iii/warcraft-vscode/commit/429d506))
* Object generator level values saved incorrect ([d26923f](https://github.com/warcraft-iii/warcraft-vscode/commit/d26923f))



## [0.0.31](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.30...v0.0.31) (2020-04-20)



## [0.0.30](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.29...v0.0.30) (2020-01-07)


### Bug Fixes

* Object generator sometimes do not need to execute ([40f8650](https://github.com/warcraft-iii/warcraft-vscode/commit/40f8650))



## [0.0.29](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.28...v0.0.29) (2019-12-25)


### Features

* add simple code confusion ([ead7aa7](https://github.com/warcraft-iii/warcraft-vscode/commit/ead7aa7))



## [0.0.28](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.27...v0.0.28) (2019-12-24)


### Bug Fixes

* .def is no longer extracted when there are multiple folders in the workspace ([2032b2d](https://github.com/warcraft-iii/warcraft-vscode/commit/2032b2d))



## [0.0.27](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.26...v0.0.27) (2019-12-20)



## [0.0.26](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.25...v0.0.26) (2019-12-19)


### Bug Fixes

* package.json merge error ([db37f85](https://github.com/warcraft-iii/warcraft-vscode/commit/db37f85))


### Features

* packing objects ([44b65de](https://github.com/warcraft-iii/warcraft-vscode/commit/44b65de))



## [0.0.25](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.24...v0.0.25) (2019-12-18)


### Bug Fixes

* string call expression ([c3e0832](https://github.com/warcraft-iii/warcraft-vscode/commit/c3e0832))


### Features

* Hide status bar item in non project ([fa203dc](https://github.com/warcraft-iii/warcraft-vscode/commit/fa203dc))



## [0.0.24](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.23...v0.0.24) (2019-07-02)


### Bug Fixes

* Add library ([7b3d371](https://github.com/warcraft-iii/warcraft-vscode/commit/7b3d371))



## [0.0.23](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.22...v0.0.23) (2019-06-28)


### Bug Fixes

* Identical files with different paths require multiple times ([e9f1943](https://github.com/warcraft-iii/warcraft-vscode/commit/e9f1943))


### Features

* Add config for define library remotes ([e8c13f6](https://github.com/warcraft-iii/warcraft-vscode/commit/e8c13f6))
* Ignore archived repo ([d2aba2d](https://github.com/warcraft-iii/warcraft-vscode/commit/d2aba2d))



## [0.0.22](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.21...v0.0.22) (2019-06-27)


### Features

* Add API seterrorhandler geterrorhandler ([ab14f03](https://github.com/warcraft-iii/warcraft-vscode/commit/ab14f03))



## [0.0.21](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.20...v0.0.21) (2019-06-26)


### Features

* support package.path ([34405b6](https://github.com/warcraft-iii/warcraft-vscode/commit/34405b6))



## [0.0.20](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.19...v0.0.20) (2019-06-25)


### Bug Fixes

* release compiler resolve file error ([d0c18c5](https://github.com/warcraft-iii/warcraft-vscode/commit/d0c18c5))



## [0.0.19](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.18...v0.0.19) (2019-06-21)


### Features

* Add command `toggle configuration` ([5221906](https://github.com/warcraft-iii/warcraft-vscode/commit/5221906))
* Add config files ([eea028e](https://github.com/warcraft-iii/warcraft-vscode/commit/eea028e))
* Add function: dofile loadfile ([92cf5ea](https://github.com/warcraft-iii/warcraft-vscode/commit/92cf5ea))
* Add warcraft.json validation ([bbc3e83](https://github.com/warcraft-iii/warcraft-vscode/commit/bbc3e83))



## [0.0.18](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.17...v0.0.18) (2019-06-13)


### Bug Fixes

* luamin's bug ([8373866](https://github.com/warcraft-iii/warcraft-vscode/commit/8373866))


### Features

* The imports folder from the library will import into the map ([d6ef0f1](https://github.com/warcraft-iii/warcraft-vscode/commit/d6ef0f1))



## [0.0.17](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.16...v0.0.17) (2019-05-30)


### Bug Fixes

* some bugs ([e6b5e42](https://github.com/warcraft-iii/warcraft-vscode/commit/e6b5e42))


### Features

* add compile release ([e57fde9](https://github.com/warcraft-iii/warcraft-vscode/commit/e57fde9))
* add compile release (wip) ([b9ff591](https://github.com/warcraft-iii/warcraft-vscode/commit/b9ff591))



## [0.0.16](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.15...v0.0.16) (2019-05-27)



## [0.0.15](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.14...v0.0.15) (2019-05-27)



## [0.0.14](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.13...v0.0.14) (2019-05-27)


### Features

* Add project create ([c820a1c](https://github.com/warcraft-iii/warcraft-vscode/commit/c820a1c))
* localize ([e013649](https://github.com/warcraft-iii/warcraft-vscode/commit/e013649))



## [0.0.13](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.12...v0.0.13) (2019-05-21)


### Features

* add Auto Close client config ([9268cbe](https://github.com/warcraft-iii/warcraft-vscode/commit/9268cbe))
* Add the "imports" folder ([ab418aa](https://github.com/warcraft-iii/warcraft-vscode/commit/ab418aa))



## [0.0.12](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.11...v0.0.12) (2019-05-15)


### Bug Fixes

* compile debug ([bcc8615](https://github.com/warcraft-iii/warcraft-vscode/commit/bcc8615))



## [0.0.11](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.10...v0.0.11) (2019-05-13)



## [0.0.10](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.9...v0.0.10) (2019-05-10)


### Features

* Added option command ([3a18283](https://github.com/warcraft-iii/warcraft-vscode/commit/3a18283))



## [0.0.9](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.8...v0.0.9) (2019-05-09)



## [0.0.8](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.7...v0.0.8) (2019-05-08)


### Bug Fixes

* bug ([4ee7caf](https://github.com/warcraft-iii/warcraft-vscode/commit/4ee7caf))



## [0.0.7](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.6...v0.0.7) (2019-04-25)


### Bug Fixes

* pack map ([ab3f904](https://github.com/warcraft-iii/warcraft-vscode/commit/ab3f904))



## [0.0.6](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.5...v0.0.6) (2019-04-25)


### Features

* added progress notification ([39ca068](https://github.com/warcraft-iii/warcraft-vscode/commit/39ca068))



## [0.0.5](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.4...v0.0.5) (2019-04-25)



## [0.0.4](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.3...v0.0.4) (2019-04-25)



## [0.0.3](https://github.com/warcraft-iii/warcraft-vscode/compare/v0.0.2...v0.0.3) (2019-04-24)


### Features

* Added command "Add Library" ([557019b](https://github.com/warcraft-iii/warcraft-vscode/commit/557019b))



## 0.0.2 (2019-04-24)



