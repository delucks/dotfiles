set disas intel

define reg_check
disp /x $esp
disp /x $ebp
disp /x $eax
disp /x $ebx
disp /x $ecx
disp /x $edx
disp /x $eip
end

define soon
disassemble $eip $eip+4
end

define flags
printf "Flags:\n"
if ($eflags & 1)
printf "CF "
end
if ($eflags & 4)
printf "PF "
end
if ($eflags & 16)
printf "AF "
end
if ($eflags & 64)
printf "ZF "
end
if ($eflags & 128)
printf "SF "
end
if ($eflags & 2048)
printf "OF"
end
printf "\n"
end
