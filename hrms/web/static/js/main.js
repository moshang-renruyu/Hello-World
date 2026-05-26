/* ============================================
   HRMS 人事管理系统 - 全局脚本
   ============================================ */

function confirmDelete(url) {
    if (confirm('确认要删除该记录吗？此操作不可恢复。')) {
        window.location.href = url;
    }
    return false;
}

function confirmAction(msg, url) {
    if (confirm(msg)) {
        window.location.href = url;
    }
    return false;
}

function validateForm(formId) {
    var form = document.getElementById(formId);
    if (!form) return true;
    var required = form.querySelectorAll('[required]');
    for (var i = 0; i < required.length; i++) {
        var el = required[i];
        if (!el.value || el.value.trim() === '') {
            var label = el.previousElementSibling;
            var name = label ? label.textContent.replace('*', '').trim() : '字段';
            alert(name + ' 不能为空');
            el.focus();
            return false;
        }
    }
    return true;
}

function validateLogin() {
    var username = document.getElementById('username');
    var password = document.getElementById('password');
    if (!username.value.trim()) {
        alert('请输入用户名');
        username.focus();
        return false;
    }
    if (!password.value.trim()) {
        alert('请输入密码');
        password.focus();
        return false;
    }
    return true;
}

function validateRegister() {
    var username = document.getElementById('username');
    var password = document.getElementById('password');
    var confirm = document.getElementById('confirm');
    var realName = document.getElementById('realName');
    if (!username.value.trim()) { alert('请输入用户名'); username.focus(); return false; }
    if (username.value.length < 3) { alert('用户名至少3个字符'); username.focus(); return false; }
    if (!realName.value.trim()) { alert('请输入真实姓名'); realName.focus(); return false; }
    if (!password.value.trim()) { alert('请输入密码'); password.focus(); return false; }
    if (password.value.length < 6) { alert('密码至少6位'); password.focus(); return false; }
    if (password.value !== confirm.value) { alert('两次密码输入不一致'); confirm.focus(); return false; }
    return true;
}

function validateEmployee() {
    var name = document.getElementById('name');
    var empNo = document.getElementById('empNo');
    var phone = document.getElementById('phone');
    if (!empNo.value.trim()) { alert('请输入工号'); empNo.focus(); return false; }
    if (!name.value.trim()) { alert('请输入姓名'); name.focus(); return false; }
    if (phone.value && !/^1[3-9]\d{9}$/.test(phone.value)) { alert('手机号格式不正确'); phone.focus(); return false; }
    var email = document.getElementById('email');
    if (email.value && !/^[\w.-]+@[\w.-]+\.\w+$/.test(email.value)) { alert('邮箱格式不正确'); email.focus(); return false; }
    var idCard = document.getElementById('idCard');
    if (idCard && idCard.value && !/^\d{17}[\dXx]$/.test(idCard.value)) { alert('身份证号格式不正确'); idCard.focus(); return false; }
    return true;
}

function validateSalary() {
    var empId = document.getElementById('empId');
    var month = document.getElementById('month');
    if (!empId.value) { alert('请选择员工'); empId.focus(); return false; }
    if (!month.value) { alert('请选择月份'); month.focus(); return false; }
    calcSalary();
    return true;
}

function calcSalary() {
    var base = parseFloat(document.getElementById('baseSalary').value) || 0;
    var bonus = parseFloat(document.getElementById('bonus').value) || 0;
    var allowance = parseFloat(document.getElementById('allowance').value) || 0;
    var overtime = parseFloat(document.getElementById('overtimePay').value) || 0;
    var deduction = parseFloat(document.getElementById('deduction').value) || 0;
    var insurance = parseFloat(document.getElementById('insurance').value) || 0;
    var tax = parseFloat(document.getElementById('tax').value) || 0;
    var actual = base + bonus + allowance + overtime - deduction - insurance - tax;
    var el = document.getElementById('actualSalary');
    if (el) el.value = actual.toFixed(2);
    var display = document.getElementById('actualDisplay');
    if (display) display.textContent = actual.toFixed(2);
}

function loadPositions(deptId, selectedId) {
    if (!deptId) return;
    var xhr = new XMLHttpRequest();
    var ctx = document.getElementById('ctx') ? document.getElementById('ctx').value : '';
    xhr.open('GET', ctx + '/position.do?method=getByDept&deptId=' + deptId, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var list = JSON.parse(xhr.responseText);
            var sel = document.getElementById('positionId');
            if (!sel) return;
            sel.innerHTML = '<option value="">-- 请选择职位 --</option>';
            for (var i = 0; i < list.length; i++) {
                var opt = document.createElement('option');
                opt.value = list[i].id;
                opt.textContent = list[i].name;
                if (selectedId && list[i].id == selectedId) opt.selected = true;
                sel.appendChild(opt);
            }
        }
    };
    xhr.send();
}

function goToPage(pageNum) {
    var form = document.getElementById('searchForm');
    if (form) {
        var input = form.querySelector('input[name="pageNum"]');
        if (!input) {
            input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'pageNum';
            form.appendChild(input);
        }
        input.value = pageNum;
        form.submit();
    }
}

function autoHideAlert() {
    var alerts = document.querySelectorAll('.alert');
    for (var i = 0; i < alerts.length; i++) {
        (function (el) {
            setTimeout(function () {
                el.style.opacity = '0';
                el.style.transition = 'opacity 0.3s';
                setTimeout(function () { el.style.display = 'none'; }, 300);
            }, 3000);
        })(alerts[i]);
    }
}

window.onload = function () {
    autoHideAlert();
};
