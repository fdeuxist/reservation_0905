function initializeMenuToggle() {
    function toggleMenu() {
        var dropdownMenu = $("#dropdown-menu");
        dropdownMenu.toggle();
    }

    $(".menu-button").click(toggleMenu);
}