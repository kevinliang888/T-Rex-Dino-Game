module datapath2(colour, resetn, clock, draw, en_xy, en_delay, erase_colour, x, y, colour_out, finish_draw, finish_erase);
    input resetn, clock;
	input en_xy, en_delay, erase_colour, draw;
	input [2:0] colour;
	
	output reg finish_draw, finish_erase;
	output  [7:0] x;
	output  [6:0] y;
	output reg [2:0] colour_out;
	
	reg [7:0] x_original;
	reg [6:0] y_original;
	reg [3:0] q, frame;
	reg [19:0] delay;
	reg right, down;
	wire en_frame;
	
	always @(posedge clock)
	begin: delay_counter
		if (!resetn)
			delay <= 20'd833333;
	    else if (en_delay)
		begin
			if (delay == 0)
			    delay <= 20'd833333;
			else
			    delay <= delay - 1'b1;
		end
	end
	
	assign en_frame = (delay == 20'd0)? 1: 0;
	
	always @(posedge clock)
	begin: frame_counter
	    if (!resetn)
		    frame <= 4'd0;
		else if (en_frame)
		begin
		    if (frame == 4'd14)
			    frame <= 4'd0;
			else
			    frame <= frame + 1'b1;
		end
	end
	assign finish_draw = (frame == 4'd14) ? 1 : 0;
	
	always @(posedge clock)
	begin: x_counter
	    if (!resetn)
		    x_original <= 8'd0;
		else if (en_xy)
		begin
		    if (right)
			    x_original <= x_original + 1'b1;
			else
			    x_original <= x_original - 1'b1;
		end
	end
	
	always @(posedge clock)
	begin: y_counter
	    if (!resetn)
		    y_original <= 8'd0;
		else if (en_xy)
		begin
		    if (down)
			    y_original <= y_original + 1'b1;
			else
			    y_original <= y_original - 1'b1;
		end
	end
	
	always @(posedge clock)
	begin: horizontal_register
	    if(!resetn)
		    right <= 1'b1;
		else 
		begin
		    if (x == 8'd0)
			    right <= 1'b1;
			else if (x == 8'd159)
			    right <= 1'b0;
		end
	end
	
	always @(posedge clock)
	begin: vertical_register
	    if (!resetn)
		    down <= 1'b1;
		else
		begin
		    if (y == 8'd0)
			    down <= 1'b1;
			else if (y == 7'd119)
			    down <= 1'b0;
		end
	end
	
	always @(posedge clock)
	begin: counter
		if (!resetn) begin
			q <= 4'b0000;
			finish_erase <= 1'b0;
			end
		else if (draw)
			begin
				if (q == 4'b1111) begin
					q <= 0;
					finish_erase <= 1'b1;
					end
				else begin
					q <= q + 1'b1;
					finish_erase <= 1'b0;
					end
			end
	end
	
	assign x = x_original + q[1:0];
	assign y = y_original + q[3:2];
	
endmodule
	
	
				
		
		
		
		
		
		
		
		
		
		
		    