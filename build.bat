@REM 关闭回显，不显示正在执行的批处理命令及执行的结果等。
@echo off

@REM 工程编译输出
echo "stream server windows build project."

call :prepare_env
call :modify_version
call :build
@REM call :tag_version
@REM call :symstore

goto :EOF


@REM 1.设置环境变量
:prepare_env

echo "call env.bat if exist"
if exist env.bat (call env.bat)

goto :EOF

:modify_version

echo "modify version.h"
if defined CI_PIPELINE_ID (tools\version version.h tools\version.rc %CI_PIPELINE_ID%) else (
	echo "No CI_PIPELINE_ID found, use the default build id."
)

goto :EOF


@REM 2.构建
:build

echo "build"

call "%WATCH_VC_DIR%\vcvarsall.bat" amd64

if exist build (echo "build folder exist.") else (md build)
cd build/

if exist x64-windows-rel (echo "x64-windows-rel folder exist.") else (md x64-windows-rel)
cd x64-windows-rel
cmake ../../ -DCMAKE_TOOLCHAIN_FILE="%WATCH_VCPKG_DIR%/scripts/buildsystems/vcpkg.cmake" -DCMAKE_INSTALL_PREFIX=../package/x64-windows -DCMAKE_BUILD_TYPE=RelWithDebInfo -G "NMake Makefiles"

if %errorlevel% NEQ 0 (
	echo "cmake failed"
	pause
	exit
)

nmake

if %errorlevel% NEQ 0 (
	echo "nmake failed"
	pause
	exit
)

@REM nmake install

@REM if %errorlevel% NEQ 0 (
@REM 	echo "nmake install failed"
@REM 	pause
@REM 	exit
@REM )

cd ../../

xcopy /d /y /f  "build/x64-windows-rel/realtime_server/*.pdb"  "build/package/x64-windows/bin"

goto :EOF


@REM 3.版本
:tag_version

echo "tag version"
tools\ResourceHacker -open tools/version.rc -save tools/version.res -action compile
tools\ResourceHacker -open build/package/x64-windows/bin/realtime_server.exe -save build/package/x64-windows/bin/realtime_server.exe -action addoverwrite -res tools/version.res

if %errorlevel% NEQ 0 (
	echo "tag version failed"
	pause
	exit
)

goto :EOF


@REM 4.构建
:symstore

echo "symstore"

if defined WATCH_DEBUGGERS  (
	if defined WATCH_SYMBOL_DIR (echo "WATCH_DEBUGGERS and WATCH_SYMBOL_DIR are set.") else (
		echo "please set the 2 env variables: WATCH_DEBUGGERS, WATCH_SYMBOL_DIR in env.bat, and retry again."
		pause
		exit
	)
)  else  (
	echo "please set the 2 env variables: WATCH_DEBUGGERS, WATCH_SYMBOL_DIR in env.bat, and retry again."
	pause
	exit
)

SET PATH=%WATCH_DEBUGGERS%;%PATH%
symstore add /r /f build/package/x64-windows /s %WATCH_SYMBOL_DIR% /t PreprocessWorker

if %errorlevel% NEQ 0 (
	echo "symstore failed"
	pause
	exit
)

call :symcheck

goto :EOF


@REM 5.构建
:symcheck

echo "symcheck"

symchk /it symchklist.txt /s %WATCH_SYMBOL_DIR%

if %errorlevel% NEQ 0 (
	echo "symchk failed"
	pause
	exit
)

goto :EOF