# Install script for Temaruk's dotfiles

INSTALL_DIR=${HOME}
OS=`uname -s`

# Output formatting
TITLE = @echo '[+]'
SEPARATOR=echo "\n-----\n"
ifndef VERBOSE
	Q = @
else
	Q = @echo ' '
endif

general_modules = zsh git vim
# Todo: add osx support properly

# Main make target, installs everything
all: $(general_modules)

zsh:
	$(TITLE) "Installing zsh"
	$(Q)cp zshrc ${INSTALL_DIR}/.zshrc && echo 'Installed .zshrc'
	$(Q)cp -r zkbd ${INSTALL_DIR}/.zkbd && echo 'Installed .zkbd directory'
	$(Q)touch ${INSTALL_DIR}/.z_cache
	$(Q)cp bash_profile ${INSTALL_DIR}/.bash_profile && echo 'Installed .bash_profile'
	$(Q)cp shell_aliases ${INSTALL_DIR}/.shell_aliases && echo 'Installed .shell_aliases'
	$(Q)cp osx_aliases ${INSTALL_DIR}/.osx_aliases && echo 'Installed .osx_aliases'
	$(Q)chsh -s `which zsh` || echo 'Failed to set zsh as default shell, install it and make zsh'

git:
	$(TITLE) "Installing git config"
	$(Q)cp gitconfig ${INSTALL_DIR}/.gitconfig && echo 'Installed .gitconfig'
	$(Q)cp gitignore_global ${INSTALL_DIR}/.gitignore_global && echo 'Installed .gitignore_global'
	$(Q)cp gitk ${INSTALL_DIR}/.gitk && echo 'Installed .gitk'

vim:
	$(TITLE) "Installing vim config"
	$(Q)cp vimrc ${INSTALL_DIR}/.vimrc && echo 'Installed .vimrc'
	$(Q)cp -r vim ${INSTALL_DIR}/.vim && echo 'Installed .vim directory'

diff:
	$(TITLE) "Diffing dotfiles\n"
	$(Q)echo "| zshrc:\n"
	$(Q)diff zshrc ${INSTALL_DIR}/.zshrc || $(SEPARATOR)
	$(Q)echo "| zkbd:\n"
	$(Q)diff zkbd ${INSTALL_DIR}/.zkbd || $(SEPARATOR)
	$(Q)echo "| bash_profile:\n"
	$(Q)diff bash_profile ${INSTALL_DIR}/.bash_profile || $(SEPARATOR)
	$(Q)echo "| shell_aliases:\n"
	$(Q)diff shell_aliases ${INSTALL_DIR}/.shell_aliases || $(SEPARATOR)
	$(Q)echo "| osx_aliases:\n"
	$(Q)diff osx_aliases ${INSTALL_DIR}/.osx_aliases || $(SEPARATOR)

	$(Q)echo "| gitconfig:\n"
	$(Q)diff gitconfig ${INSTALL_DIR}/.gitconfig || $(SEPARATOR)
	$(Q)echo "| gitignore_global:\n"
	$(Q)diff gitignore_global ${INSTALL_DIR}/.gitignore_global || $(SEPARATOR)
	$(Q)echo "| gitk:\n"
	$(Q)diff gitk ${INSTALL_DIR}/.gitk || $(SEPARATOR)

	$(Q)echo "| vimrc:\n"
	$(Q)diff vimrc ${INSTALL_DIR}/.vimrc || $(SEPARATOR)
	$(Q)echo "| vim:\n"
	$(Q)diff vim ${INSTALL_DIR}/.vim || $(SEPARATOR)

# @todo: Solve if VERBOSE=true
clean:
	$(TITLE)Deleting temporary files