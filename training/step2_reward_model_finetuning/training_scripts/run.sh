#!/bin/bash
# Copyright (c) Microsoft Corporation.
# SPDX-License-Identifier: Apache-2.0

# DeepSpeed Team
OUTPUT=$1
ZERO_STAGE=$2
if [ "$OUTPUT" == "" ]; then
    OUTPUT=./output
fi
if [ "$ZERO_STAGE" == "" ]; then
    ZERO_STAGE=0
fi
mkdir -p $OUTPUT

deepspeed --include localhost:0,1,2,3,4,5,6,7 --master_port 29000  /root/llama1/DeepSpeed-Chat/training/step2_reward_model_finetuning/main.py \
   --data_path /root/llama1/DeepSpeed-Chat/Cohere/miracl-zh-queries-22-12 \
   --data_split 2,4,4 \
   --model_name_or_path /root/llama1/rl_dpo/chatglm2-6b \
   --num_padding_at_beginning 1 \
   --per_device_train_batch_size 1 \
   --per_device_eval_batch_size 1 \
   --max_seq_len 512 \
   --learning_rate 5e-5 \
   --weight_decay 0.1 \
   --num_train_epochs 1 \
   --disable_dropout \
   --gradient_accumulation_steps 2 \
   --lr_scheduler_type cosine \
   --num_warmup_steps 0 \
   --seed 1234 \
   --data_output_path data_files \
   --zero_stage $ZERO_STAGE \
   --deepspeed \
   --output_dir $OUTPUT \
   &> $OUTPUT/training.log

sh step2_reward_model_finetuning/training_scripts/other_language/run.sh output 2