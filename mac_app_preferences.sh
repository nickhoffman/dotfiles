#!/bin/bash

operation="$1"
app_name="$2"

apps=(
  "iTerm2:com.googlecode.iterm2"
  "Rectangle:com.knollsoft.Rectangle"
  "AltTab:com.lwouis.alt-tab-macos"
  "Alfred:com.runningwithcrayons.Alfred-Preferences"
  "MeetingBar:com.stripe.jil.meetingbar"
  "Bartender:com.surteesstudios.Bartender"
  "CleanShot X:pl.maketheweb.cleanshotx"
)

library_prefs_dir="$HOME/Library/Preferences"
stored_prefs_dir="$(cd "$(dirname "$0")" && pwd)/misc/app_preferences"

import_preferences() {
  for app in "${apps[@]}"; do
    name="${app%%:*}"
    bundle_id="${app##*:}"
    import_path="$stored_prefs_dir/$bundle_id.plist"

    if [[ -n "$(lsappinfo find bundleid="$bundle_id")" ]]; then
      echo "WARNING: $name is running. Quit it to import its preferences."
    elif [[ -f "$import_path" ]]; then
      if defaults import "$bundle_id" "$import_path"; then
        echo "Imported $name"
      fi
    else
      echo "ERROR: $name preferences file is missing: $import_path"
    fi
  done
}

export_preferences() {
  for app in "${apps[@]}"; do
    name="${app%%:*}"
    bundle_id="${app##*:}"
    plist="$library_prefs_dir/$bundle_id.plist"

    if [[ -f "$plist" ]]; then
      export_path="$stored_prefs_dir/$bundle_id.plist"
      if defaults export "$bundle_id" "$export_path" && plutil -convert xml1 "$export_path"; then
        echo "Exported $name to $export_path"
      fi
    else
      echo "$name: plist not found at $plist"
    fi
  done
}

# Limit the operation to a single app when one is named.
if [[ -n "$app_name" ]]; then
  selected_apps=()
  for app in "${apps[@]}"; do
    if [[ "${app%%:*}" == "$app_name" ]]; then
      selected_apps=("$app")
    fi
  done

  if [[ ${#selected_apps[@]} -eq 0 ]]; then
    echo "ERROR: Unknown app: $app_name"
    echo "Valid apps:"
    for app in "${apps[@]}"; do
      echo "  ${app%%:*}"
    done
    exit 1
  fi

  apps=("${selected_apps[@]}")
fi

case "$operation" in
  import)
    import_preferences
    ;;
  export)
    export_preferences
    ;;
  *)
    echo "ERROR: Invalid operation."
    exit 1
    ;;
esac
