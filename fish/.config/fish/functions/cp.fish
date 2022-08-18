function cp --wraps='rsync -ah --info=progress2' --description 'alias cp=rsync -ah --info=progress2'
  rsync -ah --info=progress2 $argv; 
end
