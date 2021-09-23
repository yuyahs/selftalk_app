'use strict';
{
  document.addEventListener("DOMContentLoaded", () => {

    let i = 45;

    function count(){
      i -- ;
      const doc0 = document.getElementById('countdown');
      doc0.textContent= `${i}`;
      document.getElementById('progress').setAttribute('value', i);
      if(i == 0 ) {
        clearInterval(intervalId);
      }
    }
    const intervalId = setInterval(count, 1000);

  });





}