echo $(sensors | grep fan1 | awk '{print $2}')
