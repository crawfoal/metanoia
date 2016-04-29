$('body > [class*="flash-"]').slideUp()
$('main').before("<%= escape_javascript(render_flash) %>")
