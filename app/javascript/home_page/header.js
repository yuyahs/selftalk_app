'user strict';
{
  function hamburger() {
    document.getElementById('line1').classList.toggle('line_1');
    document.getElementById('line2').classList.toggle('line_2');
    document.getElementById('line3').classList.toggle('line_3');
    document.getElementById('nav').classList.toggle('in');
  }
  onload = function(){
    document.getElementById('hamburger').addEventListener('click', () =>  {
    hamburger();
  } )};

}