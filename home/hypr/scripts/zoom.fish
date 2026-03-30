if test (hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}' | tr -d '[:space:]') = "1.000000"
    hyprctl keyword cursor:zoom_factor 2
else
    hyprctl keyword cursor:zoom_factor 1
end
