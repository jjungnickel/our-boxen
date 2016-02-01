class people::jjungnickel {
  include zsh
  include dotfiles
  include fonts::adobe::sourcecodepro
  include iterm2::stable
  include iterm2::colors::tomorrow_night_eighties

  homebrew::tap { 'railwaycat/homebrew-emacsmacport': }
  package { 'emacs-mac':
    ensure => present,
    install_options => [ '--with-spacemacs-icon' ]
 }
}
