l = ' Human: 月球到地球的距离是多少？ Assistant:月球距離 (LD) 是天文學上從地球到月球的距離，從地球到月球的平均距離是384,401公里 (238,856英里)。因為月球在橢圓軌道上運動，實際的距離隨時都在變化著。'

sentence = l.replace('Human:', '问：')
sentence = sentence.replace(' Assistant:', ' 答：')

instruction = sentence.split(' 答：')[0] + ' 答：'
output = sentence.split(' 答：')[1]

print(instruction)
print(output)