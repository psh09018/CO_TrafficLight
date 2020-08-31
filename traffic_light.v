module traffic_light (clk,rst,pass,R,G,Y);

input  clk;
input  rst;
input  pass;
output reg R;
output reg G;
output reg Y;

reg [2:0] state;
reg [10:0] cycles;

always @ (posedge clk or posedge rst) begin
	if(rst) begin
		R<=0;
		G<=1;
		Y<=0;
		state<=3'd0;
		cycles<=11'd1;
	end
	else if(pass) begin
		if(state!=3'd0) begin
				R<=0;
				G<=1;
				Y<=0;			
				state<=3'd0;
				cycles<=11'd1;
		end
		else cycles<=cycles+11'd1;
	end
	else begin
		cycles<=cycles+11'd1;
		case(state)
			3'd0: begin  //initial state of green light
				R<=0; 
				G<=1; 
				Y<=0;
				if(cycles==11'd1023) begin
					state<=3'd1;
					cycles<=11'd0;
				end
			end
			3'd1: begin  //none1
				R<=0; 
				G<=0; 
				Y<=0;
				if(cycles==11'd127) begin
					state<=3'd2;
					cycles<=11'd0;
				end
			end
			3'd2: begin //green1
				//cycles<=cycles+11'd1;
				R<=0; 
				G<=1; 
				Y<=0;
				if(cycles==11'd127) begin
					state<=3'd3;
					cycles<=11'd0;
				end
			end
			3'd3: begin  //none2
				R<=0; 
				G<=0; 
				Y<=0;
				if(cycles==11'd127) begin
					state<=3'd4;
					cycles<=11'd0;
				end
			end
			3'd4: begin //green2
				R<=0; 
				G<=1; 
				Y<=0;
				if(cycles==11'd127) begin
					state<=3'd5;
					cycles<=11'd0;
				end
			end
			3'd5: begin  //yellow
				R<=0; 
				G<=0; 
				Y<=1;
				if(cycles==11'd511) begin
					state<=3'd6;
					cycles<=11'd0;
				end
			end
			3'd6: begin //red
				R<=1; 
				G<=0; 
				Y<=0;
				if(cycles==11'd1023) begin
					state<=3'd0;
					cycles<=11'd0;
				end
			end
		endcase
	end
end

endmodule

