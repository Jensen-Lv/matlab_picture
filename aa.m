%�Ҳ���ô��
clear;clc;
data1 = imread('cang1.jpg');
data2 = imread('cang2.jpg');
data3 = data2;
for i = 1:length(data1(1,:,1))
    for j = 1:length(data1(:,1,1))
        gray1 = data1(j,i,1)*0.1+data1(j,i,2)*0.6+data1(j,i,3)*0.3;
        gray2 = data2(j,i,1)*0.1+data2(j,i,2)*0.6+data2(j,i,3)*0.3;
        if abs(gray1 - gray2)>=20
           data3(j,i,:) = [255;0;0];
        end
    end
end
imshow(data3);



data = imread('ͼƬ1.png');
figure
imshow(data);
%ͼ��ҶȻ�
for i = 1:length(data(1,:,1))
    for j = 1:length(data(:,1,1))
        %gray = data(j,i,1)*0.3+data(j,i,2)*0.6+data(j,i,3)*0.1;
        gray = data(j,i,1)*0.1+data(j,i,2)*0.6+data(j,i,3)*0.3;
        data(j,i,1) = gray;
        data(j,i,2) = gray;
        data(j,i,3) = gray;
    end
end
figure
imshow(data);
%ͼ���ֵ������
for i = 1:length(data(1,:,1))
    for j = 1:length(data(:,1,1))
        if data(j,i,1)<=150
            data(j,i,:) = [0;0;0];
        else
            data(j,i,:) = [255;255;255];
        end
    end
end
figure 
imshow(data);
%ͼ���ݶ���
data = double(data)                  
[Gx,Gy] = gradient(data);               
G=sqrt(Gx.*Gx+Gy.*Gy);          
J=data; 
K=find(G>=250);                   
J(K)=255;
figure
imshow(J);
data = J;
%ȥ��ɢ����
data = rgb2gray(data);
data = medfilt2(data);
figure
imshow(data);

%ͼ����б�ȵ���
mid_r = 0; %��¼�ұ߷������ص��ƽ���߶�
mid_l = 0; %��¼��߷������ص��ƽ���߶�
count_r = 0; %�ұ߷������ص�ĸ���
count_l = 0; %��߷������ص�ĸ���
[m n] = size(data);
for i = 1:length(data(:,1))
    for j = 1:length(data(1,:))
        if data(i,j) ~= 0 && j <=  n/2
            mid_l = mid_l + i*10;
            count_l = count_l + 1;
        elseif data(i,j) ~= 0 && j >  n/2
            mid_r = mid_r + i*10;
            count_r = count_r + 1;
        end
    end
end
mid_l = mid_l/count_l;
mid_r = mid_r/count_r;
tan = (mid_r-mid_l)/(n/2);
a = imcomplement(data);
a = imrotate(a,abs(atan(tan)*57.1));
data = imcomplement(a);
figure
imshow(data);

%ͼ��ָ�
[m n] = size(data);
step = round(n/10);
for i = 1:step:n-1
    figure
    imshow(data(1:m,i:i+step));
end


%�򵥵�3dģ�͹���
clc;clear;
for i = 1:56
    bmpname = [num2str(i-1,'%03d'),'.JPG']; 
    figi = im2double(imread(bmpname));  
    I{i} = figi;
end
data = {};
for i = 1:56
    data{i} = rgb2gray(I{i});
end
gray_data = [];
for i = 1:56
    for j = 1:256
        for k = 1:256
            gray_data(i,j,k) = data{i}(j,k,1);
        end
    end 
end 
grid on
for i = 1:56
    for j = 1:4:256
        for k = 1:4:256
            if gray_data(i,j,k)>0.8
                hold on
                plot3(k*0.01,j,i,'k.','MarkerSize',15)
            end
        end
    end 
end 







