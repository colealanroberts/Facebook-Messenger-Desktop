!include "MUI2.nsh"

Name "Messenger"
BrandingText "aluxian.com"
RequestExecutionLevel "admin"

# set the icon
!define MUI_ICON "icon.ico"

# define the resulting installer's name:
OutFile "..\dist\MessengerSetup.exe"

# set the installation directory
InstallDir "$PROGRAMFILES\Messenger for Desktop\"

# app dialogs
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_RUN_TEXT "Start Messenger"
!define MUI_FINISHPAGE_RUN $INSTDIR\Messenger.exe

!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"

# default section start
Section
  # set the current shell context to the current users
  SetShellVarContext "current"
  # delete the installed files
  RMDir /r $INSTDIR

  # define the path to which the installer should install
  SetOutPath $INSTDIR

  # specify the files to go in the output path
  File /r ..\build\Messenger\win32\*

  # create the uninstaller
  WriteUninstaller "$INSTDIR\Uninstall Messenger for Desktop.exe"

  # create shortcuts in the start menu and on the desktop
  CreateShortCut "$APPDATA\Microsoft\Windows\Start Menu\Programs\Messenger.lnk" "$INSTDIR\Messenger.exe"
  CreateShortCut "$APPDATA\Microsoft\Windows\Start Menu\Programs\Uninstall Messenger for Desktop.lnk" "$INSTDIR\Uninstall Messenger for Desktop.exe"
  CreateShortCut "$DESKTOP\Messenger.lnk" "$INSTDIR\Messenger.exe"

SectionEnd

# create a section to define what the uninstaller does
Section "Uninstall"
  # set the current shell context to the current users
  SetShellVarContext "current"
  # delete the installed files
  RMDir /r $INSTDIR

  # delete the shortcuts
  Delete "$APPDATA\Microsoft\Windows\Start Menu\Programs\Messenger.lnk"
  Delete "$APPDATA\Microsoft\Windows\Start Menu\Programs\Uninstall Messenger for Desktop.lnk"
  Delete "$DESKTOP\Messenger.lnk"

SectionEnd