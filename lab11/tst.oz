local NewStack Push Pop IsEmpty S1 S2 S3 X A1 A2 Push2 Pop2 IsEmpty2 in
   fun {NewStack}
      local StackOps Out in
         fun {StackOps S}
            local Push Pop IsEmpty in
               Push = fun {$ N}
                  local Out in
                     Out = {StackOps (N|S)}
                     Out
                  end
               end
               Pop = fun {$ E}
                  local Out in 
                     case S
                        of nil then Out
                        [] '|'(1:H 2:T) then
                        E = H
                        Out = {StackOps T}
                        Out
                     end
                  end
               end
               IsEmpty = fun{$}
                  (S == nil)
               end
               ops(push:Push pop:Pop isEmpty: IsEmpty)
            end
         end
         Out = {StackOps nil}
         Out
      end
   end
   S1 = {NewStack}
   ops(push:Push pop:Pop isEmpty: IsEmpty) = S1
   A1 = {IsEmpty}
   S2 = {Push 23}
   ops(push:Push2 pop:Pop2 isEmpty: IsEmpty2) = S2
   S3 ={Pop2 X}
   skip Browse X
end