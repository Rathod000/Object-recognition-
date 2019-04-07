I=input('Enter the NOrmalized value of Image ');
I = (I(:,:) - mu_inp(:,1)) / sigma_inp(:,1);
 patterns = size(I,1);
 bias = ones(patterns,1);
 I = [I bias];
 Ans = weight_hidden_output*tanh(I*weight_input_hidden)';
B=imread('Banana.jpg');
A=imread('Apple.jpg');
  
 if (Ans > 0)
  image(B);
 else
  image(A);   
 end
  display(Ans); 