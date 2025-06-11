package handy4cj

import std.collection.*

const reshapePlaceholderDefault = r'#'

public func reshapePH(placeHolder: Rune, format: String, sequence: String): String {
    if (placeHolder == r'\0' || format == "" || sequence == "") {
        return sequence
    }
    let hashes = format.count(placeHolder.toString())
    let positions = sequence.toRuneArray().size

    var j = 0
    let result = ArrayList<Rune>([])

    for (i in format.toRuneArray()) {
        if (j >= positions) {
            break
        }
        if (i != placeHolder) {
            result.append(i)
        } else {
            result.append(sequence.toRuneArray()[j])
            j++
        }
    }

    if (hashes < positions) {
        sequence[Range<Int64>(hashes, positions - 1, 1, true, true, true)].toRuneArray() |> forEach<Rune>(result.append)
    }
    return String(result)
}

public func reshape(format: String, sequence: String): String {
    return reshapePH(reshapePlaceholderDefault, format, sequence)
}
