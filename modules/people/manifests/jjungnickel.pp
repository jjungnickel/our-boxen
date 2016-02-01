class people::jjungnickel {
  include zsh
  include dotfiles
  include fonts::larsenwork::monoid
  include fonts::adobe::sourcecodepro

  homebrew::tap { 'railwaycat/homebrew-emacsmacport': }
  package { 'emacs-mac':
    ensure => present,
    install_options => [ '--with-spacemacs-icon' ]
 }
}
