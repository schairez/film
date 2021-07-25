import java.io.File

def recursiveListFiles(f: File): Array[File] = {
    val these = f.listFiles
    these ++ these.filter(_.isDirectory).flatMap(recursiveListFiles)
}
val f = recursiveListFiles(new File(".")) 

