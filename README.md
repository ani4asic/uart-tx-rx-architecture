# uart-protocol
# UART Transmitter and Receiver in Verilog

> A synthesizable Verilog-based implementation of a Universal Asynchronous Receiver/Transmitter (UART) supporting **230400 baud communication** using a **3.125 MHz system clock**, featuring parity generation/detection and FSM-based control logic for reliable asynchronous serial communication.

![Language](https://img.shields.io/badge/Language-Verilog-blue)
![Protocol](https://img.shields.io/badge/Protocol-UART-orange)
![RTL](https://img.shields.io/badge/Design-RTL-success)

---

# Overview

This project was developed as part of the **e-Yantra Robotics Competition (eYRC) 2024**, under the **Logistic CoBot (LC)** theme organized by **IIT Bombay**.

The objective was to design and implement a complete **UART Transmitter (TX)** and **UART Receiver (RX)** in Verilog HDL to enable reliable asynchronous serial communication between digital systems.

The design supports **230400 baud communication** using a **3.125 MHz system clock** and implements a UART frame consisting of **1 Start Bit, 8 Data Bits, 1 Parity Bit, and 1 Stop Bit**. FSM-based control logic was developed for both the transmitter and receiver to ensure deterministic frame transmission and reliable data recovery.

---

# Project Highlights

* Developed as part of **e-Yantra Robotics Competition (eYRC) 2024 – Logistic CoBot (LC) Theme**
* Synthesizable Verilog RTL implementation
* UART Transmitter and Receiver architecture
* 230400 baud communication using a 3.125 MHz system clock
* FSM-based transmission and reception
* Parity generation and detection
* End-to-end functional verification
* Modular and reusable RTL design

---

# UART Frame Format

The implemented UART frame follows the structure below:

```text
+---------+-------------+----------+---------+
| Start   | 8 Data Bits | Parity   | Stop    |
|   0     | D0 ... D7   |    P     |    1    |
+---------+-------------+----------+---------+
```

* Data is transmitted **LSB first**
* Even parity is used for error detection

---

# System Architecture

```text
                Parallel Data
                      │
                      ▼
             UART Transmitter
                      │
                Serial TX Line
                      │
                      ▼
              UART Receiver
                      │
                      ▼
              Recovered Data
```

---

# Transmitter Operation

The transmitter FSM performs the following sequence:

```text
IDLE
  │
  ▼
START BIT
  │
  ▼
DATA BITS
  │
  ▼
PARITY BIT
  │
  ▼
STOP BIT
  │
  ▼
IDLE
```

The transmitter converts parallel input data into a serialized UART frame while maintaining the configured baud rate.

---

# Receiver Operation

The receiver continuously monitors the incoming serial line.

Upon detecting a valid start bit, it:

* Samples incoming data bits
* Reconstructs the transmitted byte
* Performs parity verification
* Detects the stop bit
* Outputs the received data

FSM-based control ensures accurate synchronization and reliable data recovery.

---

# Repository Structure

```text
uart-transmitter-receiver/

├── README.md
├── RTL/
│   UART transmitter and receiver RTL modules
│
├── TB/
│   Functional verification testbench

```

---

# Verification

The complete UART architecture was functionally verified through Verilog simulation.

Verification included:

* ✔ UART transmission
* ✔ UART reception
* ✔ Start bit detection
* ✔ Data serialization
* ✔ Data deserialization
* ✔ Parity generation
* ✔ Parity verification
* ✔ Stop bit detection
* ✔ End-to-end UART communication
* ✔ FSM state transitions

The receiver successfully reconstructed the transmitted data, validating reliable UART communication at the configured baud rate.

---

# Design Specifications

| Parameter              |       Value |
| ---------------------- | ----------: |
| Communication Protocol |        UART |
| RTL Language           | Verilog HDL |
| System Clock           |   3.125 MHz |
| Baud Rate              |  230400 bps |
| Data Bits              |           8 |
| Parity                 |        Even |
| Stop Bits              |           1 |

---

# Applications

* FPGA-Based Communication Systems
* Embedded Systems
* Microcontroller Interfaces
* Sensor and Peripheral Communication
* Serial Debug Interfaces
* Robotics and Automation Systems

---

# Tools Used

### Language

* Verilog HDL

### Development Environment

* Intel Quartus Prime

---

# Skills Demonstrated

* Verilog HDL
* RTL Design
* FSM Design
* UART Protocol
* Asynchronous Serial Communication
* Baud Rate Generation
* Parity Generation and Detection
* Functional Verification
* Digital System Design

---

# Future Enhancements

* Configurable baud rate generator
* Variable data width support
* FIFO buffering
* Interrupt generation
* Hardware implementation on FPGA
* AXI UART wrapper

---

# License

This repository is intended for educational and research purposes.

# NOTE
the testbench for the project was provided as a cocotb file during the competetion. Hence the complete TB may be unavailable!
