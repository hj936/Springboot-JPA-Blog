let index = {
	init: function() {
		$("#btn-save").on("click", () => {
			this.save();
		});
		$("#btn-update").on("click", () => {
			this.update();
		});
	},

	save: function() {
		//alert('user의 save함수 호출됨');
		let data = {
			username: $("#username").val(),
			password: $("#password").val(),
			email: $("#email").val()

		};

		//console.log(data);

		$.ajax({
			type: "POST",
			url: "/auth/joinProc",
			data: JSON.stringify(data),
			contentType: "application/json; charset=utf-8",
			dataType: "json"
		}).done(function(resp) {
			if (resp.status === 500) {
				alert("회원가입 실패");
			} else {
				alert("회원가입 완료");
				location.href = "/";
			}

		}).fail(function(error) {
			alert(JSON.stringify(error));
		});
	},

	update: function() {
		//alert('user의 save함수 호출됨');
		let data = {
			id: $("#id").val(),
			username: $("#username").val(),
			password: $("#password").val(),
			email: $("#email").val()

		};

		//console.log(data);
		if (data.password == '') {
			alert("비밀번호를 입력해주세요.");
		} else {
			$.ajax({
				type: "PUT",
				url: "/user",
				data: JSON.stringify(data),
				contentType: "application/json; charset=utf-8",
				dataType: "json"
			}).done(function(resp) {
				alert("회원수정 완료");
				//console.log(resp);
				location.href = "/";
			}).fail(function(error) {
				alert(JSON.stringify(error));
			});
		}

	}


}

index.init();