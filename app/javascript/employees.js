 setActives = (employee) => {
     var csrf = document.querySelector('meta[name="csrf-token"]').content;
     var xhr = new XMLHttpRequest();
     xhr.open("DELETE", "employees/"+ employee);
     xhr.setRequestHeader('X-CSRF-Token', csrf);
     xhr.send();
     xhr.onload = function() {
         if (xhr.status != 200) {
             console.log('ERROR');
         } else {
             console.log('DELETED!');
         }
     };
     xhr.onerror = function() {
         console.log('NO CONNECTION');
     };
}
