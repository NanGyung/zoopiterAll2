const signUp = document.querySelector('.signUp');
const signUpH = document.querySelector('.signUpH');

const scrollBox = document.querySelector('.scroll-box');
const scrollCheckbox = document.querySelector('#scroll-checkbox');

scrollBox.addEventListener('scroll', () => {
    if (
        scrollBox.scrollTop + scrollBox.clientHeight >=
<<<<<<< HEAD
        scrollBox.scrollHeight -1
=======
        scrollBox.scrollHeight
>>>>>>> da5ce351b86ee6c962102094e12e181cba872639
    ) {
        scrollCheckbox.checked = true;
        scrollCheckbox.disabled = false;
    } else {
        scrollCheckbox.checked = false;
        scrollCheckbox.disabled = true;
    }
    if (scrollCheckbox.checked && scrollCheckbox2.checked) {
        signUp.disabled = false;
        signUpH.disabled = false;
    } else {
        signUp.disabled = true;
        signUpH.disabled = true;
    }
});

const scrollBox2 = document.querySelector('.scroll-box2');
const scrollCheckbox2 = document.querySelector('#scroll-checkbox2');

scrollBox2.addEventListener('scroll', () => {
    if (
        scrollBox2.scrollTop + scrollBox2.clientHeight >=
<<<<<<< HEAD
        scrollBox2.scrollHeight -1
=======
        scrollBox2.scrollHeight
>>>>>>> da5ce351b86ee6c962102094e12e181cba872639
    ) {
        scrollCheckbox2.checked = true;
        scrollCheckbox2.disabled = false;
    } else {
        scrollCheckbox2.checked = false;
        scrollCheckbox2.disabled = true;
    }
    if (scrollCheckbox.checked && scrollCheckbox2.checked) {
        signUp.disabled = false;
        signUpH.disabled = false;
    } else {
        signUp.disabled = true;
        signUpH.disabled = true;
    }
});