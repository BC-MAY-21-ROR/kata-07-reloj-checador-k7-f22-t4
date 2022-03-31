setActives = (employee) => {
  var csrf = document.querySelector('meta[name="csrf-token"]').content;
  var xhr = new XMLHttpRequest();
  xhr.open("DELETE", "employees/" + employee);
  xhr.setRequestHeader("X-CSRF-Token", csrf);
  xhr.send();
  xhr.onload = function () {
    if (xhr.status != 204) {
      alert("Ocurrió un error");
    } else {
        alert("Operación exitosa");
    }
  };
  xhr.onerror = function () {
    console.log("Error de conexión");
  };
};
