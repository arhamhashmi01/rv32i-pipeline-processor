# RV32I 5-Stage Pipeline Processor

Welcome to the RV32I 5-Stage Pipeline Processor repository! This repository hosts the implementation of a highly efficient processor design based on the RISC-V ISA (Instruction Set Architecture), focusing on the RV32I subset. The RV32I instruction set is particularly well-suited for educational purposes, embedded systems, and various other applications due to its simplicity and versatility.

## Introduction to RISC-V

RISC-V is an open standard ISA designed with simplicity, modularity, and scalability in mind. It is based on reduced instruction set computing (RISC) principles, offering a clean and elegant architecture that facilitates ease of understanding, implementation, and extensibility. RISC-V has gained significant traction across academia and industry, becoming a preferred choice for various computing systems ranging from microcontrollers to supercomputers.

## 5-Stage Pipeline Overview

The 5-stage pipeline architecture is a cornerstone in modern processor design, offering a systematic approach to instruction execution. This pipeline divides the instruction execution process into five distinct stages:

  **Fetch:** In this stage, the processor fetches the instruction from memory using the program counter (PC) and prepares it for decoding.

  **Decode:** The fetched instruction is decoded, and the necessary control signals are generated to facilitate the execution of the instruction. Additionally, register operands are read from the register file in this stage.

  **Execute:** In this stage, arithmetic, logic, or control operations specified by the instruction are executed. This stage may involve ALU (Arithmetic Logic Unit) operations, branch calculations, or other computational tasks.

  **Memory:** If the instruction requires memory access (e.g., load or store operations), this stage facilitates the interaction between the processor and memory subsystem.

  **Write-back:** The final stage involves writing the results of the executed instruction back to the register file. This stage completes the instruction execution cycle.

## Block Diagram

The block diagram provides a visual representation of the RV32I 5-Stage Pipeline Processor architecture, illustrating the flow of instructions through the various pipeline stages.

<img src="https://github.com/arhamhashmi01/rv32i-pipeline-processor/blob/main/images/microprocessor.jpeg" alt="RV32I Pipeline Microprocessor Image">

## 5-Stage Pipeline Features

The RV32I 5-Stage Pipeline Processor incorporates several features aimed at enhancing efficiency, simplicity, and modularity:

  **Efficiency:** By leveraging pipelining, the processor achieves improved throughput by allowing multiple instructions to be in different stages of execution simultaneously.

  **Simplicity:** Each pipeline stage is dedicated to a specific task, enhancing the clarity and comprehensibility of the processor design.

  **Modularity:** The modular nature of the pipeline stages enables easy extension and customization to accommodate additional features or optimizations as required.

## Hazards and Solutions

The pipeline architecture introduces certain hazards that need to be effectively managed to ensure correct program execution and maintain performance. The RV32I 5-Stage Pipeline Processor addresses these hazards as follows:

  **Data Hazards:** Data hazards occur when an instruction depends on the result of a previous instruction still in the pipeline. To mitigate data hazards, the processor implements forwarding mechanisms, allowing the result of a computation to be forwarded to subsequent stages of the pipeline, thereby resolving data dependencies without stalling the pipeline.

  **Control Hazards:** Control hazards arise from conditional branch instructions, potentially causing the pipeline to execute instructions incorrectly due to changes in control flow. The processor addresses control hazards by employing a combination of techniques such as pipeline flushing and stalling. In cases where a branch instruction's outcome is uncertain, the pipeline is stalled until the branch outcome is determined, ensuring correct program execution. Additionally, when a branch is taken, any instructions fetched after the branch but before the branch outcome is known are flushed from the pipeline to prevent incorrect execution.

## Verification

Verification of the processor through gtkwave.

<img src="https://github.com/arhamhashmi01/rv32i-pipeline-processor/blob/main/images/gtkwave.png" alt="Gtkwave Image">

## Getting Started

To begin exploring the RV32I 5-Stage Pipeline Processor:

  **1)** Clone this repository to your local machine:

     git clone https://github.com/arhamhashmi01/rv32i-pipeline-processor.git

  **2)** Navigate to the project directory:

     cd rv32i-5stage-pipeline

  **3)** Refer to the documentation provided in the repository to build, simulate, or test the processor implementation.

  **4)** Experiment with the design, explore optimizations, or integrate additional features to further enhance the processor's capabilities.

## Contribution

Contributions to this project are highly encouraged and appreciated! Whether it's bug fixes, feature enhancements, or optimizations, your contributions can help improve the overall quality and functionality of the RV32I 5-Stage Pipeline Processor.

