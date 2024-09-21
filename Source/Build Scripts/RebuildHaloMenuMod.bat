
@echo off

cls

:: Local Directory Variables (Modify As Needed)
set engine_dir=E:\Game Dev\Unreal Engine\UE_4.21\Engine
set repo_dir=E:\Game Dev\Mods\Halo MCC Menu Overhaul\3 - New MCC UE4 Project
set game_dir=D:\Games\Steam\steamapps\common\Halo The Master Chief Collection

echo on

@echo. && echo /////////////////////// && echo /// Cooking Project /// && echo /////////////////////// && echo.

:: Cook Unreal Assets
@call "%engine_dir%\Build\BatchFiles\RunUAT.bat" BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project="%repo_dir%\Source\Unreal Project\MCC\MCC.uproject" -cook -skipstage -ue4exe=UE4Editor-Cmd.exe -targetplatform=Win64 -utf8output

@echo. && echo ///////////////////// && echo /// Cleaning Cook /// && echo ///////////////////// && echo.

:: Remove Extra Cook Files
rmdir "%repo_dir%\Source\Unreal Project\MCC\Saved\Cooked\WindowsNoEditor\MCC\Metadata" /s /q
del "%repo_dir%\Source\Unreal Project\MCC\Saved\Cooked\WindowsNoEditor\MCC\AssetRegistry.bin"
echo Deleting generated cook files.

@echo. && echo /////////////////////////// && echo /// Generating Pak File /// && echo /////////////////////////// && echo.

:: Compress Cooked Assets into Pak in Final Mod Directory
@call "%engine_dir%\Binaries\Win64\UnrealPak.exe" "%game_dir%\MCC\Content\Paks\~mods\MCC-WindowsNoEditor_P.pak" -Create="%repo_dir%\Source\Build Scripts\ContentToRepack.txt"

@echo. && echo ////////////////////// && echo /// Build Complete /// && echo ////////////////////// && echo.