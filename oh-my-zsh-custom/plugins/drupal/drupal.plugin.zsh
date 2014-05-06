#
# Drupal and drush
#

# Download Drupal in a project folder via drush.
dldrupal() {
  drush dl --drupal-project-rename="$*";
}

# Download a Drupal project, use git submodules for checking out
# new projects.
draddsub() {
  drush -d dl "$*" --package-handler=git_drupalorg --gitsubmodule;
}

# Run PHP_CodeSniffer on folder/file.
drupalcs() {
  phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme "$*";
}

# Disable and uninstall Drupal modules via drush.
drushdisun() {
  drush -y dis "$*"; drush -y pm-uninstall "$*"; drush cron;
}

# Enable Drupal modules via drush.
drushen() {
  drush -y en "$*"; drush cc all;
}

# Install Drupal site via drush.
drushsi() {
  if [[ $# -eq 1 ]]; then
    drush -y si --account-name="$1" --account-pass="$1";
  elif [[ $# -eq 2 ]]; then
    drush -y si "$1" --account-name="$2" --account-pass="$2";
  fi
}