function addCode(key){
  var code = document.getElementById("attendance_employee_id");
  if(code.value.length < 6){
    code.value = code.value + key;
  }
}

function deleteChar(){
  var code = document.getElementById("attendance_employee_id");
  code.value = code.value.substring(0, code.value.length - 1);
}

function deleteCode(){
  var code = document.getElementById("attendance_employee_id");
  code.value = "";
}

function showTime(){
  var date = new Date();
  var hour = date.getHours(); // 0 - 23
  var month = date.getMinutes(); // 0 - 59
  var second = date.getSeconds(); // 0 - 59
  var session = "AM";

  if(hour == 0){
      hour = 12;
  }

  if(hour > 12){
    hour = hour - 12;
    session = "PM";
  }

  hour = (hour < 10) ? "0" + hour : hour;
  month = (month < 10) ? "0" + month : month;
  second = (second < 10) ? "0" + second : second;

  var time = hour + ":" + month + ":" + second + " " + session;
  document.getElementById("MyClockDisplay").innerText = time;
  document.getElementById("MyClockDisplay").textContent = time;

  setTimeout(showTime, 1000);
}

showTime();
