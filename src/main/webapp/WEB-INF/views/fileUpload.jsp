<%@ page import="kopo.poly.dto.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자전거 여행</title>
	<script src="https://code.jquery.com/jquery-3.6.0.js">
		const MAX_IMAGE_UPLOAD = 10;
		let imageFileDict = {};
		let imageFileDictKey = 0;

		function registerListener() {

		...

			// 이미지 파일 입력 리스너
			$('#article-images').on('change', function (e) {
				let files = e.target.files;
				let filesArr = Array.prototype.slice.call(files);

				// 업로드 될 파일 총 개수 검사
				let totalFileCnt = Object.keys(imageFileDict).length + filesArr.length
				if (totalFileCnt > MAX_IMAGE_UPLOAD) {
					alert("이미지는 최대 " + MAX_IMAGE_UPLOAD + "개까지 업로드 가능합니다.");
					return;
				}

				filesArr.forEach(function (file) {
					if (!file.type.match("image.*")) {
						alert("이미지 파일만 업로드 가능합니다.");
						return;
					}

					let reader = new FileReader();
					reader.onload = function (e) {
						imageFileDict[imageFileDictKey] = file;

						let tmpHtml = `<div class="article-image-container" id="image-${imageFileDictKey}">
                                <img src="${e.target.result}" data-file=${file.name}
                                         class="article-image"/>
                                <div class="article-image-container-middle" onclick="removeImage(${imageFileDictKey++})">
                                    <div class="text">삭제</div>
                                </div>
                           </div>`
						$('#image-list').append(tmpHtml);
					};
					reader.readAsDataURL(file);
				});
			});
		}


		function removeImage(key) {
			delete imageFileDict[key];
			$(`#image-${key}`).remove();
		}
	</script>
</head>
<body>
<div>
	<div>
		<div id="image-list" class="modal-dynamic-contents">
			<!-- dynamic image thumbnail -->
		</div>
	</div>
	<div>
		<div class="form-group" id="article-image-form">
			<input class="form-control form-control-user modal-dynamic-contents" type="file"
				   multiple="multiple" name="article-images" id="article-images">
		</div>
	</div>
</div>
</body>
</html>