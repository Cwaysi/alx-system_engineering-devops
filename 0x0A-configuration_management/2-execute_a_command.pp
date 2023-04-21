#killing
exec { 'killmenow':
  command => 'pkill killmenow',
  onlyif  => 'pgrep killmenow',
}
