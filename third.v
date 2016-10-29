module alu_8mod(out,a,b,s);

input [8:0]a,b;

input [3:0]s;

output [8:0]out;

reg [8:0]out;

wire in1,in2;
//,flag;

always@(s)

begin

case(s)

4'b0000:           out=a+b;                 //8-bit addition

4'b0001:           out=a-b;                  //8-bit subtraction

4'b0010:           out=a*b;                 //8-bit multiplication

4'b0011:           out=a/b;                  //8-bit division

4'b0100:           out=in1%in2;                //8-bit modulo division

4'b0101:           out=in1&&in2; //8-bit logical and

4'b0110:           out=a||b;                  //8-bit logical or

4'b0111:           out=!a;                      //8-bit logical negation

4'b1000:           out=~a;                     //8-bit bitwise negation

4'b1001:           out=a&b;                //8-bit bitwise and

4'b1010:           out=a|b;                  //8-bit bitwise or

4'b1011:           out=a^b;                 //8-bit bitwise xor

4'b1100:           out=a<<1;                 //left shift

4'b1101:           out=a>>1;                 //right shift

4'b1110:           out=a+1;                   //increment

4'b1111:           out=a-1;                    //decrement

endcase

end

 

endmodule

module multiplier(prod, busy, mc, mp, clk, start);
	output [15:0] prod;
	output busy;
	input [7:0] mc, mp;
	input clk, start;
	reg [7:0] A, Q, M;
	reg Q_1;
	reg [3:0] count;
	wire [7:0] sum, difference;
	
	always @(posedge clk)
	begin
		if (start) begin
			A <= 8'b0;
			M <= mc;
			Q <= mp;
			Q_1 <= 1'b0;
			count <= 4'b0;
		end
		else begin
			case ({Q[0], Q_1})
			2'b0_1 : {A, Q, Q_1} <= {sum[7], sum, Q};
			2'b1_0 : {A, Q, Q_1} <= {difference[7], difference, Q};
			default: {A, Q, Q_1} <= {A[7], A, Q};
			endcase
			count <= count + 1'b1;
		end
	
	end
	
	alu adder (sum, A, M, 1'b0);
	alu subtracter (difference, A, ~M, 1'b1);
	assign prod = {A, Q};
	assign busy = (count < 8);
	
endmodule
	
	
	//The following is an alu.
	//It is an adder, but capable of subtraction:
	//Recall that subtraction means adding the two's complement--
	//a - b = a + (-b) = a + (inverted b + 1)
	//The 1 will be coming in as cin (carry-in)
module alu(out, a, b, cin);
	output [7:0] out;
	input [7:0] a;
	input [7:0] b;
	input cin;
	
	assign out = a + b + cin;

endmodule
