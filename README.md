# Notes
Just some notes for different things

#TF MultiGPU
        global_step = tf.variable....
        gradients = []
        for i in range(num_gpus):
             with tf.device("/gpu:%d"%i):
                 with tf.variable_scope('model_X',reuse=(i>0)):
                     with tf.name_scope('gpu_or_tower_%d'%i):
                        # Your code here
                        compute gradients and losses
                        add stuff to colletions
       average_gradients
       with tf.device(cpu):
        train_op = opt.apply_gradients(averaged_gradients, global_step = global_Step)
       return train_op, global_Step
