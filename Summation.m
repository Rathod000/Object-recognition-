% Artificial neural network


clc;
clear all; 
close all;

%Taking 3 hidden Layer in Neural Network structure
hidden_neurons = 3;
epochs = 10000;




% ------- load in the data -------

% Normalized  Image dataset
train_inp = [0.1253   0.1127;0.333      0.2786; 0.1096   0.0988;0.3107     0.3263;0.0940   0.0846;0.1485     0.2993];
train_out = [1; 0; 1; 0; 1; 0];

% check same number of patterns in each
if size(train_inp,1) ~= size(train_out,1)
    disp('ERROR: data mismatch')
   return 
end    

%standardise the data to mean=0 and standard deviation=1
%inputs
mu_inp = mean(train_inp);
sigma_inp = std(train_inp);
train_inp = (train_inp(:,:) - mu_inp(:,1)) / sigma_inp(:,1);

%outputs
train_out = train_out';
mu_out = mean(train_out);
sigma_out = std(train_out);
train_out = (train_out(:,:) - mu_out(:,1)) / sigma_out(:,1);
train_out = train_out';

%read how many patterns
patterns = size(train_inp,1);

%add a bias as an input
bias = ones(patterns,1);
train_inp = [train_inp bias];

%read how many inputs
inputs = size(train_inp,2);

%---------- data loaded ------------

%add button for early stopping
hstop = uicontrol('Style','PushButton','String','Stop', 'Position', [5 5 70 20],'callback','earlystop = 1;'); 
earlystop = 0;

%add button for resetting weights
hreset = uicontrol('Style','PushButton','String','Reset Wts', 'Position', get(hstop,'position')+[75 0 0 0],'callback','reset = 1;'); 
reset = 0;

%add slider to adjust the learning rate
hlr = uicontrol('Style','slider','value',.1,'Min',.01,'Max',1,'SliderStep',[0.01 0.1],'Position', get(hreset,'position')+[75 0 100 0]);


% ---------- set weights -----------------
%set initial random weights
weight_input_hidden = (randn(inputs,hidden_neurons) - 0.5)/10;
weight_hidden_output = (randn(1,hidden_neurons) - 0.5)/10;



%----------------------------------------
%--- Training weights in Neural Network--
%----------------------------------------

%do a number of epochs
for iter = 1:epochs
    
    %get the learning rate from the slider
    alr = get(hlr,'value');
    blr = alr / 10;
    
    %loop through the patterns, selecting randomly
    for j = 1:patterns
        
        %select a random pattern
        patnum = round((rand * patterns) + 0.5);
        if patnum > patterns
            patnum = patterns;
        elseif patnum < 1
            patnum = 1;    
        end
       
        %set the current pattern
        this_pat = train_inp(patnum,:);
        act = train_out(patnum,1);
        
        %calculate the current error for this pattern
        hval = (tanh(this_pat*weight_input_hidden))';
        pred = hval'*weight_hidden_output';
        error = pred - act;

        % adjust weight hidden - output
        delta_HO = error.*blr .*hval;
        weight_hidden_output = weight_hidden_output - delta_HO';

        % adjust the weights input - hidden
        delta_IH= alr.*error.*weight_hidden_output'.*(1-(hval.^2))*this_pat;
        weight_input_hidden = weight_input_hidden - delta_IH';
        
    end
    % -- another epoch finished
    
    %plot overall network error at end of each epoch
    pred = weight_hidden_output*tanh(train_inp*weight_input_hidden)';
    error = pred' - train_out;
    err(iter) =  (sum(error.^2))^0.5;
    
    figure(1);
    plot(err)
    
    
    %reset weights if requested
    if reset
        weight_input_hidden = (randn(inputs,hidden_neurons) - 0.5)/10;
        weight_hidden_output = (randn(1,hidden_neurons) - 0.5)/10;
        fprintf('weights reaset after %d epochs\n',iter);
        reset = 0;
    end
    
    %stop if requested
    if earlystop
        fprintf('stopped at epoch: %d\n',iter); 
        break 
    end 

    %stop if error is small
    if err(iter) < 0.001
        fprintf('converged at epoch: %d\n',iter);
        break 
    end
       
end
%{
   %-----FINISHED--------- 
   %display actual,predicted & error
   fprintf('state after %d epochs\n',iter);
   a = (train_out* sigma_out(:,1)) + mu_out(:,1);
   b = (pred'* sigma_out(:,1)) + mu_out(:,1);
   act_pred_err = [a b b-a]
 
   
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
   
   
  %} 