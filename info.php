<?php
if (isset($_SERVER['HTTP_X_INFO']) && $_SERVER['HTTP_X_INFO'] === 'yes') {
    phpinfo();
} else {
    echo "Header X_INFO is not set to 'yes'.";
}
?>