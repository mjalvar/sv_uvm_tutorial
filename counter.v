// Arenal Technology
// SV UVM training

module counter #(
    parameter CNT_INPUT_SIZE = 2,
    parameter CNT_SIZE = 16
) (
    input reset_L,
    input clk,
    input clear,
    input en,
    input [CNT_INPUT_SIZE-1:0] inc,
    output logic non_zero_value,
    output logic error_overflow,
    output logic [ CNT_SIZE-1:0] value
);

    wire [CNT_SIZE:0] next_value;
    assign next_value = value+inc;

    always_ff @(posedge clk) begin
        if( reset_L==0 ) begin
            error_overflow <= 1'b0;
            value <= {CNT_SIZE{1'b0}};
        end
        else begin
            if( clear ) begin
                error_overflow <= 1'b0;
                value <= {CNT_SIZE{1'b0};
            end
            else
                if( en )
                    {error_overflow,value} <= next_value|{error_overflow,{CNT_SIZE{1'b0}}};
        end
    end

    assign non_zero_value = |value;

endmodule
