const addCode = (key) => {
  let code = document.getElementById("attendance_employee_id");
  if(code.value.length < 6) {
    code.value = code.value + key;
  }
}

const deleteChar = () => {
  let code = document.getElementById("attendance_employee_id");
  code.value = code.value.substring(0, code.value.length - 1);
}

const deleteCode = () => {
  let code = document.getElementById("attendance_employee_id");
  code.value = "";
}

const showTime = () => {
  let date = new Date();
  let hour = date.getHours(); // 0 - 23
  let month = date.getMinutes(); // 0 - 59
  let second = date.getSeconds(); // 0 - 59
  let session = "AM";

  if (hour == 0) {
      hour = 12;
  }

  if (hour > 12) {
    hour = hour - 12;
    session = "PM";
  }

  hour = (hour < 10) ? "0" + hour : hour;
  month = (month < 10) ? "0" + month : month;
  second = (second < 10) ? "0" + second : second;

  let time = hour + ":" + month + ":" + second + " " + session;
  document.getElementById("my-clock-display").innerText = time;

  setInterval(showTime, 1000);
}

showTime();
