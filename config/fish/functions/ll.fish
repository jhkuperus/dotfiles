function ll --wraps='exa --long --colour=always --header --git' --description 'List files in a long format'
  exa --long --colour=always --header --git --all $argv; 
end
