package handy4cj

import std.core.*
import std.regex.*
import std.unicode.*


public class ComplexString{
    //判断字符串中是否有数字字符
    public func hasNumber(s: String): Bool{
        for (i in s.toRuneArray()){
            if(r'i'.isNumber()){
                return true
            }
        }
        return false
    }

    //判断字符串中是否有字母字符
    public func hasLetter(s: String): Bool{
        for (i in s.toRuneArray()){
            if(r'i'.isLetter()){
                return true 
            }
        }
        return false
    }

    //判断字符串中是否有非字母数字空格字符
    public func hasSymbol(s: String): Bool{
        for (i in s.toRuneArray()){
            if(!r'i'.isWhiteSpace() && !r'i'.isLetter() && !r'i'.isNumber()){
                return true 
            }
        }
        return false
    }
    
}   