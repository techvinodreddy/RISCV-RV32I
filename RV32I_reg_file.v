/* Register Bank
 * There are total 32 registers avaliable
 *  Register Discription  (https://en.wikichip.org/wiki/risc-v/registers)
 *     -------------------------------------------------------------------------------------
 *         5-bit Encoding | Register | ABI Name  |	    Description	
 *     -------------------------------------------------------------------------------------  
 *             0	       |   x0	  | zero	  |  hardwired zero	
 *             1	       |   x1	  | ra	      |  return address	
 *             2	       |   x2	  | sp	      |  stack pointer	
 *             3	       |   x3	  | gp	      |  global pointer	
 *             4	       |   x4	  | tp	      |  thread pointer	
 *             5	       |   x5	  | t0	      |  temporary register 0	
 *             6	       |   x6	  | t1	      |  temporary register 1	
 *             7	       |   x7	  | t2	      |  temporary register 2	
 *             8	       |   x8	  | s0 / fp	  |  saved register 0 / frame pointer	
 *             9	       |   x9	  | s1	      |  saved register 1	
 *             10	       |   x10	  | a0	      |  function argument 0 / return value 0	
 *             11	       |   x11	  | a1	      |  function argument 1 / return value 1        
 *             12	       |   x12	  | a2	      |  function argument 2	
 *             13	       |   x13	  | a3	      |  function argument 3	
 *             14	       |   x14	  | a4	      |  function argument 4	
 *             15	       |   x15	  | a5	      |  function argument 5	
 *             16	       |   x16	  | a6	      |  function argument 6	
 *             17	       |   x17	  | a7	      |  function argument 7	
 *             18	       |   x18	  | s2	      |  saved register 2	
 *             19	       |   x19	  | s3	      |  saved register 3	
 *             20	       |   x20	  | s4	      |  saved register 4	
 *             21	       |   x21	  | s5	      |  saved register 5	
 *             22	       |   x22	  | s6	      |  saved register 6	
 *             23	       |   x23	  | s7	      |  saved register 7	
 *             24	       |   x24	  | s8	      |  saved register 8	
 *             25	       |   x25	  | s9	      |  saved register 9	
 *             26	       |   x26	  | s10	      |  saved register 10	
 *             27	       |   x27	  | s11	      |  saved register 11	
 *             28	       |   x28	  | t3	      |  temporary register 3
 *             29	       |   x29	  | t4	      |  temporary register 4
 *             30	       |   x30	  | t5	      |  temporary register 5
 *             31	       |   x31	  | t6	      |  temporary register 6
 *     -------------------------------------------------------------------------------------
 * 
 */

module reg_file (
    input         clock,
    input         reset,
    input  [ 4:0] rd_addr_in,
    input  [ 4:0] rs1_addr_in,
    input  [ 4:0] rs2_addr_in,
    input  [31:0] rd_data_in,
    output [31:0] rs1_data_out,
    output [31:0] rs2_data_out
);

    reg [31:0] reg_file_bank [31:0];
    reg [31:0] rs1_data_r;
    reg [31:0] rs2_data_r;

    integer reg_rst_cnt;

    always @(posedge clock)
    begin
        if(reset)
            for(reg_rst_cnt = 0; reg_rst_cnt <= 32; reg_rst_cnt = reg_rst_cnt + 1)
                reg_file_bank[reg_rst_cnt] <= 0;

        else if(rd_addr_in != 0)
                reg_file_bank[rd_addr_in] <= rd_data_in;
    end

    always @*
    begin
        rs1_data_r = reg_file_bank[rs1_addr_in];
        rs2_data_r = reg_file_bank[rs2_addr_in];
    end

    assign rs1_data_out = rs1_data_r;
    assign rs2_data_out = rs2_data_r;

endmodule