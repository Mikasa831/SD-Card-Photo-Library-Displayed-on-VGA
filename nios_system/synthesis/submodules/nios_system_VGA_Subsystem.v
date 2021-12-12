// nios_system_VGA_Subsystem.v

// Generated using ACDS version 16.1 196

`timescale 1 ps / 1 ps
module nios_system_VGA_Subsystem (
		input  wire [1:0]  pixel_dma_control_slave_address,    // pixel_dma_control_slave.address
		input  wire [3:0]  pixel_dma_control_slave_byteenable, //                        .byteenable
		input  wire        pixel_dma_control_slave_read,       //                        .read
		input  wire        pixel_dma_control_slave_write,      //                        .write
		input  wire [31:0] pixel_dma_control_slave_writedata,  //                        .writedata
		output wire [31:0] pixel_dma_control_slave_readdata,   //                        .readdata
		input  wire        pixel_dma_master_readdatavalid,     //        pixel_dma_master.readdatavalid
		input  wire        pixel_dma_master_waitrequest,       //                        .waitrequest
		output wire [31:0] pixel_dma_master_address,           //                        .address
		output wire        pixel_dma_master_lock,              //                        .lock
		output wire        pixel_dma_master_read,              //                        .read
		input  wire [15:0] pixel_dma_master_readdata,          //                        .readdata
		input  wire        sys_clk_clk,                        //                 sys_clk.clk
		input  wire        sys_reset_reset_n,                  //               sys_reset.reset_n
		output wire        vga_CLK,                            //                     vga.CLK
		output wire        vga_HS,                             //                        .HS
		output wire        vga_VS,                             //                        .VS
		output wire        vga_BLANK,                          //                        .BLANK
		output wire        vga_SYNC,                           //                        .SYNC
		output wire [7:0]  vga_R,                              //                        .R
		output wire [7:0]  vga_G,                              //                        .G
		output wire [7:0]  vga_B,                              //                        .B
		input  wire        vga_pll_ref_clk_clk,                //         vga_pll_ref_clk.clk
		input  wire        vga_pll_ref_reset_reset             //       vga_pll_ref_reset.reset
	);

	wire         vga_pixel_fifo_avalon_dc_buffer_source_valid;              // VGA_Pixel_FIFO:stream_out_valid -> VGA_Pixel_RGB_Resampler:stream_in_valid
	wire  [15:0] vga_pixel_fifo_avalon_dc_buffer_source_data;               // VGA_Pixel_FIFO:stream_out_data -> VGA_Pixel_RGB_Resampler:stream_in_data
	wire         vga_pixel_fifo_avalon_dc_buffer_source_ready;              // VGA_Pixel_RGB_Resampler:stream_in_ready -> VGA_Pixel_FIFO:stream_out_ready
	wire         vga_pixel_fifo_avalon_dc_buffer_source_startofpacket;      // VGA_Pixel_FIFO:stream_out_startofpacket -> VGA_Pixel_RGB_Resampler:stream_in_startofpacket
	wire         vga_pixel_fifo_avalon_dc_buffer_source_endofpacket;        // VGA_Pixel_FIFO:stream_out_endofpacket -> VGA_Pixel_RGB_Resampler:stream_in_endofpacket
	wire         vga_dual_clock_fifo_avalon_dc_buffer_source_valid;         // VGA_Dual_Clock_FIFO:stream_out_valid -> VGA_Controller:valid
	wire  [29:0] vga_dual_clock_fifo_avalon_dc_buffer_source_data;          // VGA_Dual_Clock_FIFO:stream_out_data -> VGA_Controller:data
	wire         vga_dual_clock_fifo_avalon_dc_buffer_source_ready;         // VGA_Controller:ready -> VGA_Dual_Clock_FIFO:stream_out_ready
	wire         vga_dual_clock_fifo_avalon_dc_buffer_source_startofpacket; // VGA_Dual_Clock_FIFO:stream_out_startofpacket -> VGA_Controller:startofpacket
	wire         vga_dual_clock_fifo_avalon_dc_buffer_source_endofpacket;   // VGA_Dual_Clock_FIFO:stream_out_endofpacket -> VGA_Controller:endofpacket
	wire         vga_pixel_dma_avalon_pixel_source_valid;                   // VGA_Pixel_DMA:stream_valid -> VGA_Pixel_FIFO:stream_in_valid
	wire  [15:0] vga_pixel_dma_avalon_pixel_source_data;                    // VGA_Pixel_DMA:stream_data -> VGA_Pixel_FIFO:stream_in_data
	wire         vga_pixel_dma_avalon_pixel_source_ready;                   // VGA_Pixel_FIFO:stream_in_ready -> VGA_Pixel_DMA:stream_ready
	wire         vga_pixel_dma_avalon_pixel_source_startofpacket;           // VGA_Pixel_DMA:stream_startofpacket -> VGA_Pixel_FIFO:stream_in_startofpacket
	wire         vga_pixel_dma_avalon_pixel_source_endofpacket;             // VGA_Pixel_DMA:stream_endofpacket -> VGA_Pixel_FIFO:stream_in_endofpacket
	wire         vga_pixel_rgb_resampler_avalon_rgb_source_valid;           // VGA_Pixel_RGB_Resampler:stream_out_valid -> VGA_Pixel_Scaler:stream_in_valid
	wire  [29:0] vga_pixel_rgb_resampler_avalon_rgb_source_data;            // VGA_Pixel_RGB_Resampler:stream_out_data -> VGA_Pixel_Scaler:stream_in_data
	wire         vga_pixel_rgb_resampler_avalon_rgb_source_ready;           // VGA_Pixel_Scaler:stream_in_ready -> VGA_Pixel_RGB_Resampler:stream_out_ready
	wire         vga_pixel_rgb_resampler_avalon_rgb_source_startofpacket;   // VGA_Pixel_RGB_Resampler:stream_out_startofpacket -> VGA_Pixel_Scaler:stream_in_startofpacket
	wire         vga_pixel_rgb_resampler_avalon_rgb_source_endofpacket;     // VGA_Pixel_RGB_Resampler:stream_out_endofpacket -> VGA_Pixel_Scaler:stream_in_endofpacket
	wire         vga_pll_vga_clk_clk;                                       // VGA_PLL:vga_clk_clk -> [VGA_Controller:clk, VGA_Dual_Clock_FIFO:clk_stream_out, rst_controller:clk]
	wire         vga_pixel_scaler_avalon_scaler_source_valid;               // VGA_Pixel_Scaler:stream_out_valid -> avalon_st_adapter:in_0_valid
	wire  [29:0] vga_pixel_scaler_avalon_scaler_source_data;                // VGA_Pixel_Scaler:stream_out_data -> avalon_st_adapter:in_0_data
	wire         vga_pixel_scaler_avalon_scaler_source_ready;               // avalon_st_adapter:in_0_ready -> VGA_Pixel_Scaler:stream_out_ready
	wire   [1:0] vga_pixel_scaler_avalon_scaler_source_channel;             // VGA_Pixel_Scaler:stream_out_channel -> avalon_st_adapter:in_0_channel
	wire         vga_pixel_scaler_avalon_scaler_source_startofpacket;       // VGA_Pixel_Scaler:stream_out_startofpacket -> avalon_st_adapter:in_0_startofpacket
	wire         vga_pixel_scaler_avalon_scaler_source_endofpacket;         // VGA_Pixel_Scaler:stream_out_endofpacket -> avalon_st_adapter:in_0_endofpacket
	wire         avalon_st_adapter_out_0_valid;                             // avalon_st_adapter:out_0_valid -> VGA_Dual_Clock_FIFO:stream_in_valid
	wire  [29:0] avalon_st_adapter_out_0_data;                              // avalon_st_adapter:out_0_data -> VGA_Dual_Clock_FIFO:stream_in_data
	wire         avalon_st_adapter_out_0_ready;                             // VGA_Dual_Clock_FIFO:stream_in_ready -> avalon_st_adapter:out_0_ready
	wire         avalon_st_adapter_out_0_startofpacket;                     // avalon_st_adapter:out_0_startofpacket -> VGA_Dual_Clock_FIFO:stream_in_startofpacket
	wire         avalon_st_adapter_out_0_endofpacket;                       // avalon_st_adapter:out_0_endofpacket -> VGA_Dual_Clock_FIFO:stream_in_endofpacket
	wire         rst_controller_reset_out_reset;                            // rst_controller:reset_out -> [VGA_Controller:reset, VGA_Dual_Clock_FIFO:reset_stream_out]
	wire         vga_pll_reset_source_reset;                                // VGA_PLL:reset_source_reset -> rst_controller:reset_in0
	wire         rst_controller_001_reset_out_reset;                        // rst_controller_001:reset_out -> [VGA_Dual_Clock_FIFO:reset_stream_in, VGA_Pixel_DMA:reset, VGA_Pixel_FIFO:reset_stream_in, VGA_Pixel_FIFO:reset_stream_out, VGA_Pixel_RGB_Resampler:reset, VGA_Pixel_Scaler:reset, avalon_st_adapter:in_rst_0_reset]

	nios_system_VGA_Subsystem_VGA_Controller vga_controller (
		.clk           (vga_pll_vga_clk_clk),                                       //                clk.clk
		.reset         (rst_controller_reset_out_reset),                            //              reset.reset
		.data          (vga_dual_clock_fifo_avalon_dc_buffer_source_data),          //    avalon_vga_sink.data
		.startofpacket (vga_dual_clock_fifo_avalon_dc_buffer_source_startofpacket), //                   .startofpacket
		.endofpacket   (vga_dual_clock_fifo_avalon_dc_buffer_source_endofpacket),   //                   .endofpacket
		.valid         (vga_dual_clock_fifo_avalon_dc_buffer_source_valid),         //                   .valid
		.ready         (vga_dual_clock_fifo_avalon_dc_buffer_source_ready),         //                   .ready
		.VGA_CLK       (vga_CLK),                                                   // external_interface.export
		.VGA_HS        (vga_HS),                                                    //                   .export
		.VGA_VS        (vga_VS),                                                    //                   .export
		.VGA_BLANK     (vga_BLANK),                                                 //                   .export
		.VGA_SYNC      (vga_SYNC),                                                  //                   .export
		.VGA_R         (vga_R),                                                     //                   .export
		.VGA_G         (vga_G),                                                     //                   .export
		.VGA_B         (vga_B)                                                      //                   .export
	);

	nios_system_VGA_Subsystem_VGA_Dual_Clock_FIFO vga_dual_clock_fifo (
		.clk_stream_in            (sys_clk_clk),                                               //         clock_stream_in.clk
		.reset_stream_in          (rst_controller_001_reset_out_reset),                        //         reset_stream_in.reset
		.clk_stream_out           (vga_pll_vga_clk_clk),                                       //        clock_stream_out.clk
		.reset_stream_out         (rst_controller_reset_out_reset),                            //        reset_stream_out.reset
		.stream_in_ready          (avalon_st_adapter_out_0_ready),                             //   avalon_dc_buffer_sink.ready
		.stream_in_startofpacket  (avalon_st_adapter_out_0_startofpacket),                     //                        .startofpacket
		.stream_in_endofpacket    (avalon_st_adapter_out_0_endofpacket),                       //                        .endofpacket
		.stream_in_valid          (avalon_st_adapter_out_0_valid),                             //                        .valid
		.stream_in_data           (avalon_st_adapter_out_0_data),                              //                        .data
		.stream_out_ready         (vga_dual_clock_fifo_avalon_dc_buffer_source_ready),         // avalon_dc_buffer_source.ready
		.stream_out_startofpacket (vga_dual_clock_fifo_avalon_dc_buffer_source_startofpacket), //                        .startofpacket
		.stream_out_endofpacket   (vga_dual_clock_fifo_avalon_dc_buffer_source_endofpacket),   //                        .endofpacket
		.stream_out_valid         (vga_dual_clock_fifo_avalon_dc_buffer_source_valid),         //                        .valid
		.stream_out_data          (vga_dual_clock_fifo_avalon_dc_buffer_source_data)           //                        .data
	);

	nios_system_VGA_Subsystem_VGA_PLL vga_pll (
		.ref_clk_clk        (vga_pll_ref_clk_clk),        //      ref_clk.clk
		.ref_reset_reset    (vga_pll_ref_reset_reset),    //    ref_reset.reset
		.vga_clk_clk        (vga_pll_vga_clk_clk),        //      vga_clk.clk
		.reset_source_reset (vga_pll_reset_source_reset)  // reset_source.reset
	);

	nios_system_VGA_Subsystem_VGA_Pixel_DMA vga_pixel_dma (
		.clk                  (sys_clk_clk),                                     //                     clk.clk
		.reset                (rst_controller_001_reset_out_reset),              //                   reset.reset
		.master_readdatavalid (pixel_dma_master_readdatavalid),                  // avalon_pixel_dma_master.readdatavalid
		.master_waitrequest   (pixel_dma_master_waitrequest),                    //                        .waitrequest
		.master_address       (pixel_dma_master_address),                        //                        .address
		.master_arbiterlock   (pixel_dma_master_lock),                           //                        .lock
		.master_read          (pixel_dma_master_read),                           //                        .read
		.master_readdata      (pixel_dma_master_readdata),                       //                        .readdata
		.slave_address        (pixel_dma_control_slave_address),                 //    avalon_control_slave.address
		.slave_byteenable     (pixel_dma_control_slave_byteenable),              //                        .byteenable
		.slave_read           (pixel_dma_control_slave_read),                    //                        .read
		.slave_write          (pixel_dma_control_slave_write),                   //                        .write
		.slave_writedata      (pixel_dma_control_slave_writedata),               //                        .writedata
		.slave_readdata       (pixel_dma_control_slave_readdata),                //                        .readdata
		.stream_ready         (vga_pixel_dma_avalon_pixel_source_ready),         //     avalon_pixel_source.ready
		.stream_startofpacket (vga_pixel_dma_avalon_pixel_source_startofpacket), //                        .startofpacket
		.stream_endofpacket   (vga_pixel_dma_avalon_pixel_source_endofpacket),   //                        .endofpacket
		.stream_valid         (vga_pixel_dma_avalon_pixel_source_valid),         //                        .valid
		.stream_data          (vga_pixel_dma_avalon_pixel_source_data)           //                        .data
	);

	nios_system_VGA_Subsystem_VGA_Pixel_FIFO vga_pixel_fifo (
		.clk_stream_in            (sys_clk_clk),                                          //         clock_stream_in.clk
		.reset_stream_in          (rst_controller_001_reset_out_reset),                   //         reset_stream_in.reset
		.clk_stream_out           (sys_clk_clk),                                          //        clock_stream_out.clk
		.reset_stream_out         (rst_controller_001_reset_out_reset),                   //        reset_stream_out.reset
		.stream_in_ready          (vga_pixel_dma_avalon_pixel_source_ready),              //   avalon_dc_buffer_sink.ready
		.stream_in_startofpacket  (vga_pixel_dma_avalon_pixel_source_startofpacket),      //                        .startofpacket
		.stream_in_endofpacket    (vga_pixel_dma_avalon_pixel_source_endofpacket),        //                        .endofpacket
		.stream_in_valid          (vga_pixel_dma_avalon_pixel_source_valid),              //                        .valid
		.stream_in_data           (vga_pixel_dma_avalon_pixel_source_data),               //                        .data
		.stream_out_ready         (vga_pixel_fifo_avalon_dc_buffer_source_ready),         // avalon_dc_buffer_source.ready
		.stream_out_startofpacket (vga_pixel_fifo_avalon_dc_buffer_source_startofpacket), //                        .startofpacket
		.stream_out_endofpacket   (vga_pixel_fifo_avalon_dc_buffer_source_endofpacket),   //                        .endofpacket
		.stream_out_valid         (vga_pixel_fifo_avalon_dc_buffer_source_valid),         //                        .valid
		.stream_out_data          (vga_pixel_fifo_avalon_dc_buffer_source_data)           //                        .data
	);

	nios_system_VGA_Subsystem_VGA_Pixel_RGB_Resampler vga_pixel_rgb_resampler (
		.clk                      (sys_clk_clk),                                             //               clk.clk
		.reset                    (rst_controller_001_reset_out_reset),                      //             reset.reset
		.stream_in_startofpacket  (vga_pixel_fifo_avalon_dc_buffer_source_startofpacket),    //   avalon_rgb_sink.startofpacket
		.stream_in_endofpacket    (vga_pixel_fifo_avalon_dc_buffer_source_endofpacket),      //                  .endofpacket
		.stream_in_valid          (vga_pixel_fifo_avalon_dc_buffer_source_valid),            //                  .valid
		.stream_in_ready          (vga_pixel_fifo_avalon_dc_buffer_source_ready),            //                  .ready
		.stream_in_data           (vga_pixel_fifo_avalon_dc_buffer_source_data),             //                  .data
		.stream_out_ready         (vga_pixel_rgb_resampler_avalon_rgb_source_ready),         // avalon_rgb_source.ready
		.stream_out_startofpacket (vga_pixel_rgb_resampler_avalon_rgb_source_startofpacket), //                  .startofpacket
		.stream_out_endofpacket   (vga_pixel_rgb_resampler_avalon_rgb_source_endofpacket),   //                  .endofpacket
		.stream_out_valid         (vga_pixel_rgb_resampler_avalon_rgb_source_valid),         //                  .valid
		.stream_out_data          (vga_pixel_rgb_resampler_avalon_rgb_source_data)           //                  .data
	);

	nios_system_VGA_Subsystem_VGA_Pixel_Scaler vga_pixel_scaler (
		.clk                      (sys_clk_clk),                                             //                  clk.clk
		.reset                    (rst_controller_001_reset_out_reset),                      //                reset.reset
		.stream_in_startofpacket  (vga_pixel_rgb_resampler_avalon_rgb_source_startofpacket), //   avalon_scaler_sink.startofpacket
		.stream_in_endofpacket    (vga_pixel_rgb_resampler_avalon_rgb_source_endofpacket),   //                     .endofpacket
		.stream_in_valid          (vga_pixel_rgb_resampler_avalon_rgb_source_valid),         //                     .valid
		.stream_in_ready          (vga_pixel_rgb_resampler_avalon_rgb_source_ready),         //                     .ready
		.stream_in_data           (vga_pixel_rgb_resampler_avalon_rgb_source_data),          //                     .data
		.stream_out_ready         (vga_pixel_scaler_avalon_scaler_source_ready),             // avalon_scaler_source.ready
		.stream_out_startofpacket (vga_pixel_scaler_avalon_scaler_source_startofpacket),     //                     .startofpacket
		.stream_out_endofpacket   (vga_pixel_scaler_avalon_scaler_source_endofpacket),       //                     .endofpacket
		.stream_out_valid         (vga_pixel_scaler_avalon_scaler_source_valid),             //                     .valid
		.stream_out_data          (vga_pixel_scaler_avalon_scaler_source_data),              //                     .data
		.stream_out_channel       (vga_pixel_scaler_avalon_scaler_source_channel)            //                     .channel
	);

	nios_system_VGA_Subsystem_avalon_st_adapter #(
		.inBitsPerSymbol (10),
		.inUsePackets    (1),
		.inDataWidth     (30),
		.inChannelWidth  (2),
		.inErrorWidth    (0),
		.inUseEmptyPort  (0),
		.inUseValid      (1),
		.inUseReady      (1),
		.inReadyLatency  (0),
		.outDataWidth    (30),
		.outChannelWidth (0),
		.outErrorWidth   (0),
		.outUseEmptyPort (0),
		.outUseValid     (1),
		.outUseReady     (1),
		.outReadyLatency (0)
	) avalon_st_adapter (
		.in_clk_0_clk        (sys_clk_clk),                                         // in_clk_0.clk
		.in_rst_0_reset      (rst_controller_001_reset_out_reset),                  // in_rst_0.reset
		.in_0_data           (vga_pixel_scaler_avalon_scaler_source_data),          //     in_0.data
		.in_0_valid          (vga_pixel_scaler_avalon_scaler_source_valid),         //         .valid
		.in_0_ready          (vga_pixel_scaler_avalon_scaler_source_ready),         //         .ready
		.in_0_startofpacket  (vga_pixel_scaler_avalon_scaler_source_startofpacket), //         .startofpacket
		.in_0_endofpacket    (vga_pixel_scaler_avalon_scaler_source_endofpacket),   //         .endofpacket
		.in_0_channel        (vga_pixel_scaler_avalon_scaler_source_channel),       //         .channel
		.out_0_data          (avalon_st_adapter_out_0_data),                        //    out_0.data
		.out_0_valid         (avalon_st_adapter_out_0_valid),                       //         .valid
		.out_0_ready         (avalon_st_adapter_out_0_ready),                       //         .ready
		.out_0_startofpacket (avalon_st_adapter_out_0_startofpacket),               //         .startofpacket
		.out_0_endofpacket   (avalon_st_adapter_out_0_endofpacket)                  //         .endofpacket
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (vga_pll_reset_source_reset),     // reset_in0.reset
		.clk            (vga_pll_vga_clk_clk),            //       clk.clk
		.reset_out      (rst_controller_reset_out_reset), // reset_out.reset
		.reset_req      (),                               // (terminated)
		.reset_req_in0  (1'b0),                           // (terminated)
		.reset_in1      (1'b0),                           // (terminated)
		.reset_req_in1  (1'b0),                           // (terminated)
		.reset_in2      (1'b0),                           // (terminated)
		.reset_req_in2  (1'b0),                           // (terminated)
		.reset_in3      (1'b0),                           // (terminated)
		.reset_req_in3  (1'b0),                           // (terminated)
		.reset_in4      (1'b0),                           // (terminated)
		.reset_req_in4  (1'b0),                           // (terminated)
		.reset_in5      (1'b0),                           // (terminated)
		.reset_req_in5  (1'b0),                           // (terminated)
		.reset_in6      (1'b0),                           // (terminated)
		.reset_req_in6  (1'b0),                           // (terminated)
		.reset_in7      (1'b0),                           // (terminated)
		.reset_req_in7  (1'b0),                           // (terminated)
		.reset_in8      (1'b0),                           // (terminated)
		.reset_req_in8  (1'b0),                           // (terminated)
		.reset_in9      (1'b0),                           // (terminated)
		.reset_req_in9  (1'b0),                           // (terminated)
		.reset_in10     (1'b0),                           // (terminated)
		.reset_req_in10 (1'b0),                           // (terminated)
		.reset_in11     (1'b0),                           // (terminated)
		.reset_req_in11 (1'b0),                           // (terminated)
		.reset_in12     (1'b0),                           // (terminated)
		.reset_req_in12 (1'b0),                           // (terminated)
		.reset_in13     (1'b0),                           // (terminated)
		.reset_req_in13 (1'b0),                           // (terminated)
		.reset_in14     (1'b0),                           // (terminated)
		.reset_req_in14 (1'b0),                           // (terminated)
		.reset_in15     (1'b0),                           // (terminated)
		.reset_req_in15 (1'b0)                            // (terminated)
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller_001 (
		.reset_in0      (~sys_reset_reset_n),                 // reset_in0.reset
		.clk            (sys_clk_clk),                        //       clk.clk
		.reset_out      (rst_controller_001_reset_out_reset), // reset_out.reset
		.reset_req      (),                                   // (terminated)
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_in1      (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

endmodule
