function varargout = RyanNN(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RyanNN_OpeningFcn, ...
                   'gui_OutputFcn',  @RyanNN_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before RyanNN is made visible.
function RyanNN_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
clc

% --- Outputs from this function are returned to the command line.
function varargout = RyanNN_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%arrayfun(@cla,findall(0,'type','axes'));
set(handles.axes6); cla; clc
popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1        
        x=-3:0.01:3;
        for i=1:1:length(x)
            if x(i)>0
               y(i)=1;
            else
               y(i)=0;
            end
        end        
        plot(x,y,'r-.');
        xlabel('x'); ylabel('y');
        title('Hardlim Neuron');
        xlim([min(x),max(x)]); ylim([min(y)-0.1,max(y)+0.1]);
        grid on
    case 2   
        x=-3:0.01:3;
        y=1./(1+exp(-2.*x));        
        plot(x,y,'r-.');
        xlabel('x'); ylabel('y');
        title('Sigmoid Neuron');
        xlim([min(x),max(x)]); ylim([min(y)-0.1,max(y)+0.1]);
        grid on
    case 3        
        x1=rand(1,401)*6-3;
        x2=rand(1,401)*6-3;
        w1=0.5; w2=0.2; w3=-0.4; w4=-0.8; w5=-0.12; w6=0.45; b1=2.4; b2=3.4; b3=-0.77;
        w7=0.17; w8=-0.12 ;b4=0.2;        
        X1=[x1; x2; ones(size(x1))];
        W1=[w1 w3 b1; w2 w4 b2];        
        W2=[w5,w6,b3; w7,w8,b4];
        N1=W1*X1;        
        F1=[tanh(N1);ones(1,size(N1,2))];             
        N2=W2*F1;       
        y=tanh(N2);
        y1=y(1,:);
        y2=y(2,:);                        
        plot(x1*0.1,'r.'); hold on;
        plot(x2*0.1,'b.');
        plot(y1,'g');
        plot(y2,'c'); hold off;
        title('MIMO NN: [x1;x2] -> [y1;y2]'); 
        legend('0.1x1','0.1x2','y1','y2');
        xlim([0,length(x1)]); ylim([min([x1*0.1,x2*0.1,y1,y2])-0.1,max([x1*0.1,x2*0.1,y1,y2])+0.1]);
        xlabel('Data Numbers');
                
    case 4
        % 類神經演算法解出XOR及OR計算器的問題_兩輸出: XOR輸出、OR輸出
        Xi=[0,1,0,1; 
            0,0,1,1];
        D=[0,1,1,0; % XOR
           0,1,1,1]; % OR
        MaxN = 1e+5; % 最大回圈數
        mu = 0.02;   % 學習率
        Neuron_Hidden=3;
        beta = 1;	% slope of the tanh activation function
        % 以上參數Xi,D,MaxN,mu,Neuron_Hidden設計為GUI(小考1)
        [x,xs] = mapminmax(Xi);
        [t,ts] = mapminmax(D);       
        Ptrain=x;
        Ttrain=t;
        Ptest=x;
        Ttest=t;
        M=Neuron_Hidden;
        [n,~] = size(Ptrain);
        [m,N] = size(Ttrain);
        alpha =mu;	% learning rate
        MaxIter = MaxN;	% maximum number of epochs        
        E = [];
        iter = 0; 
        W1 = 0.1*randn(M,n+1); W2 = 0.1*randn(m,M+1); % weights       
        while (iter < MaxIter)
              iter = iter+1;
              for i = 1:N
                v1 = W1*[Ptrain(:,i)', 1]';	
                xout1 = tanh(beta*v1);        
                g1 = beta*(1-xout1.^2);
                v2 = W2*[xout1', 1]';	
                xout2 = tanh(beta*v2);        
                g2 = beta*(1-xout2.^2);
                D2 = diag(g2)*(Ttrain(:,i)-xout2);
                D1 = diag(g1)*W2(1:m,1:M)'*D2;
                W2 = W2+alpha*D2*[xout1', 1];
                W1 = W1+alpha*D1*[Ptrain(:,i)', 1];
              end
              MSEnew = norm(Ttest-bp2val(Ptest,W1,W2,beta));
              E = [E; MSEnew];
        end
        W1
        W2  
        % 以上參數W1,W2設計為GUI(小考2)
        plot(E);
        xlabel('Iteration Numbers');
        ylabel('Norm Error');
        xlim([0,length(E)]); ylim([min(E)-0.1,max(E)+0.1]);
        X1=[1; 
            1]
        P = mapminmax('apply',X1,xs);
        y = bp2val(P,W1,W2,beta);
        O = mapminmax('reverse',y,ts)
        % 以上參數X1,O設計為GUI(小考3)
    case 5
        % 以下為期末考的程式作答區
        
end

function y = bp2val(P,W1,W2,beta)
%
% BP2VAL - output of the MLP NN with one hidden layer
%
%  y = bp2val(P,W1,W2,beta);
%
%	P		   - n by N matrix containing N, n-dimensional input vectors
%	W1			- weigths from the input to the hidden layer (icludes biases)
%	W2			- weigths from the hidden layer to the output (includes biases)
%	beta		- slope of the activation function
%	y			- m by N matrix containing N, m-dimesional output vectors

[n,N] = size(P);
[m,M] = size(W2);
y = zeros(m,N);
for i = 1:N
  v1 = W1*[P(:,i)' 1]';
  xout1 = tanh(beta*v1);
  v2 = W2*[xout1' 1]';
  xout2 = tanh(beta*v2);
  y(:,i) = xout2;
end
    


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
%printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
