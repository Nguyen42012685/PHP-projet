const menu = document.querySelector('#mobile-menu')
const menuLinks =document.querySelector('.navbar__menu')

// Display Mobile Menu
const mobileMenu = () => {
    menu.classList.toggle('is-acitve')
    menuLinks.classList.toggle('active')
}

menu .addEventListener('click', mobileMenu);